require 'test/unit'
require 'flexgem'
require 'yaml'
class FlexgemTest < Test::Unit::TestCase
  
  	def setup
        config = YAML.load 'flexmod_serial: "/dev/ttyUSB0"
flexmod_database: "../flexmod/db/development.sqlite3"
flexmod_commands: 
  - 
      command: "MOD_FREQUENCY"
      readable_name: "Frequency"
      flexgem_module: "Modulator"
      read_method: "read_frequency"
      current_value_method: "read_frequency"
  - 
      command: "MOD_SPECTRUM"
      readable_name: "Spettro"
      flexgem_module: "Modulator"
      read_method: "read_spectrum"
      current_value_method: "read_spectrum"
  - 
      command: "MOD_RFPOWER"
      readable_name: "RF Power"
      flexgem_module: "Modulator"
      read_method: "read_rfpower"
      current_value_method: "read_rfpower"
  - 
      command: "MOD_MODE"
      readable_name: "Mode"
      flexgem_module: "Modulator"
      read_method: "read_mode"
      current_value_method: "read_mode"'
        Flexgem::Comm.init config
    end
    def teardown
        Flexgem::Comm.destroy
    end 
  
  

  

#  def test_read_response
#    response_map = Flexgem::Comm.submit_command 'Mod_frequency', '107.00', '10.00'
#    #puts "RESULT CODE "+response_map["result_code"] 
#    puts response_map
#  end
#  
#   def test_read_response_par
#    response_map = Flexgem::Comm.submit_command 'Mod_frequency', '107.00'
#    #puts "RESULT CODE "+response_map["result_code"] 
#    puts response_map
#  end
#  
#  
#  
#  def test_read_baud
#    baud = Flexgem::Modulator.write_rfpower "4"
#    puts baud
#  end
#  
#  def test_read_alt_freqs
#    Flexgem::Rds.write_rds_alt_freqs "108.0","102.8","105.0","103.0","","102.4","","100.2","102.1"
#  
#    freq = Flexgem::Rds.read_rds_alt_freqs
#    puts freq
#  end
#  
# 	def test_read_rds_text
#    rds_text = "TEST, RDS TEXT"+rand(100).to_s
#    Flexgem::Rds.write_rds_text rds_text
#    new_rds_text = Flexgem::Rds.read_rds_text
#    
#    assert_equal rds_text, new_rds_text
#    
#  end 
#  
#  
#  
#  
#  def test_read_rds_name
#    rds_name = "TEST "+rand(100).to_s
#    Flexgem::Rds.write_rds_name rds_name
#    new_rds_name = Flexgem::Rds.read_rds_name
#    
#    assert_equal rds_name, new_rds_name
#    
#  end 
#  
#  def test_compare
#    Flexgem::Comm.submit_command 'Mod_frequency', '107.00', '10.00'
#    command = 'Frequency'
#    comparator = 'EQUALS'
#    value = '107000000'
#    value2 = '108000000'
#    result = Flexgem::Comparator.compare(command, comparator, value)
#    puts result
#    assert(result)
#    assert(!Flexgem::Comparator.compare(command, comparator, value2))
#    assert(Flexgem::Comparator.compare(command, 'GT', value2))
#    assert(!Flexgem::Comparator.compare(command, 'LT', value2))
#  end
  
  
  def test_db
    Flexgem::Modulator.update_frequency  
	  p '***********************************'
    raw_response = Flexgem::Modulator.read_frequency
    p raw_response
    #response = raw_response.split @end_line
	  #response_map["command"] = response[0]
	  #p response
    p '***********************************'
  end

  
  
end
