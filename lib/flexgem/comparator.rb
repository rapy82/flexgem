module Flexgem::Comparator
	
	def self.compare_alarm_condition(alarm_condition)
	  compare(alarm_condition.command,alarm_condition.comparator,alarm_condition.value)
	end
	
	def self.compare (command,comparator,value)
		comparator.upcase!
	  current_value = get_command_current_value_method(command).call
	  #puts "Comparing #{value} #{comparator} #{current_value}"
		case comparator
			when "EQUALS"
			  return current_value.to_f == value.to_f
			when "GT"
			  return current_value.to_f > value.to_f
			when "LT"
			  return current_value.to_f < value.to_f
			when "GT%"
			  setted_value = get_command_read_method(command).call
			  percent_value = value.to_f
			  threshold_value = setted_value.to_f + (setted_value.to_f * percent_value.to_f / 100 )
			  #puts "Comparing #{current_value} #{comparator} #{threshold_value}"
			  return current_value.to_f > threshold_value.to_f
			when "LT%"
  			setted_value = get_command_read_method(command).call
			  percent_value = value.to_f
			  threshold_value = setted_value.to_f - (setted_value.to_f * percent_value.to_f / 100 )
			  return current_value.to_f < threshold_value.to_f
		end
	end
	
	def self.get_command_read_method(command)
    config = Flexgem::Comm.get_config
    command_config = config.select { |e| e['readable_name']==command}.first
    
    if command_config.nil? 
      raise StandardError ,"Cannot find specified command" 
    end
    
    method_name = command_config['read_method']
    flexgem_module = command_config['flexgem_module']
    submodule = Flexgem::const_get flexgem_module
    method = submodule.method method_name
	end
	
	def self.get_command_current_value_method(command)
    config = Flexgem::Comm.get_config
    command_config = config.select { |e| e['readable_name']==command}.first
    
    if command_config.nil? 
      raise StandardError ,"Cannot find specified command" 
    end
    
    method_name = command_config['current_value_method']
    flexgem_module = command_config['flexgem_module']
    submodule = Flexgem::const_get flexgem_module
    method = submodule.method method_name
	end
	
end
