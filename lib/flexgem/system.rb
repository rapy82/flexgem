module Flexgem::System
  
  @end_line = "\r\n"
	@separator = ","

  $source_select_command = 'SOURCE_SELECT'
  $reboot_command = 'REBOOT'
  $clear_command = 'CLEAR'
  $save_command = 'SAVE'
  $echo_command = 'ECHO'
  $get_temp_command = 'GETTEMP'
  $get_audio_command = 'GETAUDIO'

	def self.read_source_select
		command = $source_select_command
		response = Flexgem::Comm.submit_command(command)
		response["values"].first
	end
	
	def self.read_source_select_message
		command = $source_select_command
		response = Flexgem::Comm.submit_command(command)
		response["messages"].first
	end
	
	def self.write_source_select(source_select)
		command = $source_select_command
		response = Flexgem::Comm.submit_command(command,source_select)
		response["values"].first
	end
	
	def self.reboot
		command = $reboot_command
		response = Flexgem::Comm.submit_command(command)
		sleep(3.seconds)
    Flexgem::Comm.read_welcome_message
    Flexgem::System.echo 0
	end
	
	def self.save
		command = $save_command
		response = Flexgem::Comm.submit_command(command)
    Flexgem::System.echo 0
	end
	
	def self.clear
		command = $clear_command
		response = Flexgem::Comm.submit_command(command)
		sleep(3.seconds)
    Flexgem::Comm.read_welcome_message
    Flexgem::System.echo 0
	end
	
	def self.echo(mode)
	  Flexgem::Comm.submit_command($echo_command,mode)
	end
	
	def self.read_flexmod_temp
	  response = Flexgem::Comm.submit_command($get_temp_command)
		response["values"].first
	end
	
	def self.read_audio
	  raw_response = Flexgem::Comm.send_command($get_audio_command)
	  response = raw_response.split @end_line
	  values = response.first
	  response_map = Hash.new
	  value_list = values.split @separator
	  
	  response_map["audio_lock"] = value_list[0].strip
	  response_map["sample_rate"] = value_list[1].strip
	  response_map["left_in_level"] = value_list[2].strip
	  response_map["right_in_level"] = value_list[3].strip
	  response_map["left_post_filter_level"] = value_list[4].strip
	  response_map["right_post_filter_level"] = value_list[5].strip
	  
	  return response_map
	end
	
	

end
