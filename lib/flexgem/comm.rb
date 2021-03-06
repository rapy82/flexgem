module Flexgem::Comm
	
		@end_line = "\r\n"
		@separator = ","
		@quote = "\""
		@command_result_separator = " "
		@@semaphore = Mutex.new
		@@sp = nil
		@@sp_enabled = false
		@@db = nil
		@@logger = nil
		
		
		

		def self.init(config)
			@@command_config = config['flexmod_commands']
			serial_port = config['flexmod_serial']
			db_path = config['flexmod_database']
			@@db = SQLite3::Database.new db_path
			@@logger = Logger.new('logfile.log','daily')
			puts "INIT SERIAL PORT: #{serial_port} "
			@@sp = SerialPort.new serial_port,115200
			@@sp.read_timeout = 100
			enable_serial
			p 'Current Working Directory: ' + Dir.pwd
			@@logger.info('Current Working Directory: ' + Dir.pwd)
			Flexgem::System.echo 0
			synchronize_flexmod
		end
		
		def self.synchronize_flexmod
		  modules = [:Modulator, :Rds, :System]
		  modules.each do |module_name|
		    submodule = Flexgem::const_get module_name
		    submodule.methods.each do |method|  
		      if method.to_s.start_with?('update') 
		        @@logger.info('Initializing method :method')
		        p "Initializing method #{method}"
		        to_call = submodule.method method
		        to_call.call
		      end
		    end
		  end
		end
		
		def self.enable_serial
		  @@sp_enabled = true
		end
		
		def self.disable_serial
		  @@sp_enabled = false
		end
		
		def self.flexmod_connected
		  @@sp_enabled
		end
		
		def self.destroy
			puts "DESTROY SERIAL PORT"
			@@sp.close
			@@sp = nil
		end
		
		def self.get_config
		  @@command_config
		end
		
		def self.get_serial
      if @@sp.nil?
        raise "Error - no Serial port configured"
      end
			return @@sp
		end
	
	  def self.get_database
	    return @@db
	  end
	
		def self.submit_command(base_command,*params)
		  response = self.send_command(base_command,params)
 			
			return create_response_map response
		end
		
		def self.send_command(base_command,*params)
		  response = ""
		  if @@sp_enabled
		  
			  @@semaphore.synchronize do
				  sp = get_serial
		
				  start = Time.now
				
			  	command = base_command
				  command = base_command + " " + params.join(", ") if params.any? 
				  #puts "Sending command #{command}"
				  command = command + @end_line
				  sp.write command
			
				  response = sp.read
		      #puts "Updating command #{base_command} value to database"
		      #p response
		      #response = escape_characters_in_string response
		      #p response.to_s
     			Flexgem::Db.update_value(base_command.strip,response)
				end
 			end
 			
			return response
		end
		
		def self.read_command_value(command)
		  #p "Read command value #{command}"
		  response = Flexgem::Db.read_value command
		  #p "Command value = #{response}"
		  #response = escape_characters_in_string response
		  #p "Parsed Command value = #{response}"
		  return create_response_map response
		end
		
		def self.read_welcome_message
		  disable_serial
		  sp = get_serial
		  sp.read
		  sleep(1.second)
		  sp.read
		  sleep(1.second)
		  sp.read
		  sleep(1.second)
		  sp.read
		  enable_serial
		end
		
		def self.create_response_map(raw_response)
			response_map = Hash.new
		  
		  if raw_response.empty? 
		    response_map["result_code"] = "-1"
		    response_map["result_message"] = "Error"
		    response_map["values"] = []
			  response_map["messages"] = []
		  else
			  response = raw_response.split @end_line

			  #response_map["command"] = response[0]
			  #p raw_response
			  #p response
			  response_map["result_code"] = response.last.split(@command_result_separator)[0]
			  response_map["result_message"] = response.last.split(@command_result_separator)[1]
			  parameter_values = []
			  parameter_messages = []
			  
			  response.each do |response_line|
				  if response_line != response.last
				    #p response_line
					  if response_line.strip.start_with?(@quote)
						  parameter_values << response_line.scan(/"([^"]*)"/)[0][0]
					  else
						  parameter_values << response_line.split(@separator)[0].strip
						  parameter_messages << response_line.split(@separator).last
					  end
				  end
			  end
			
			  response_map["values"] = parameter_values
			  response_map["messages"] = parameter_messages
			end
			
			return response_map
		end
		
end
