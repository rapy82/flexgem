module Flexgem::PowerSystem
  
  @forward_power_key = "FORWARD_POWER"
  @reflected_power_key = "REFLECTED_POWER"
  @standard_deviation_key = "STANDARD_DEVIATION"
  @power_voltage_key = "POWER_VOLTAGE"
  @fan_coil_temp_key = "FAN_COIL_TEMP"

  #The real value for those parameters is read from a os script
  #Forward power value can be setted from gem

  def self.read_forward_power
    Flexgem::Db.read_current_value(@forward_power_key)
	end
	
	def self.read_set_forward_power
    Flexgem::Db.read_value(@forward_power_key)
	end
	
	def self.update_forward_power(forward_power)
    Flexgem::Db.update_value(@forward_power_key,forward_power)
	end

	def self.read_reflected_power
	  Flexgem::Db.read_current_value(@reflected_power_key)
	end
	
	def self.read_standard_deviation
	  Flexgem::Db.read_current_value(@standard_deviation_key)
	end
	
	def self.read_power_voltage
	  Flexgem::Db.read_current_value(@power_voltage_key)
	end
	
	def self.read_fan_coil_temp
	  Flexgem::Db.read_current_value(@fan_coil_temp_key)
	end
	
	
end
