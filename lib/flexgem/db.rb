module Flexgem::Db

  def self.update_value(command,value)
    time = Time.new
    db = Flexgem::Comm.get_database
    count_query = "select count(1) from configuration_keys where section = 'flexgem' and key = '#{command}'"
    count = db.get_first_value(count_query)
    value = value.to_s

    if count.to_i > 0
      update_query = "update configuration_keys set value = '#{value}', updated_at = '#{time}' where section = 'flexgem' and key = '#{command}'"
      db.execute(update_query)
    else
      insert_query = "insert into configuration_keys (key,value,section,created_at,updated_at) VALUES('#{command}','#{value}','flexgem','#{time}','#{time}')"
      db.execute(insert_query)
    end
    #p insert_query
  end
  
  def self.delete_update_value(command,value)
    db = Flexgem::Comm.get_database
    delete_query = "delete from configuration_keys where section = 'flexgem' and key = '#{command}'"
    db.execute(delete_query)
    time = Time.new
    value = value.to_s
    insert_query = "insert into configuration_keys (key,value,section,created_at,updated_at) VALUES('#{command}','#{value}','flexgem','#{time}','#{time}')"
    #p insert_query
    db.execute(insert_query)
  end
  
  def self.read_value(command)
    db = Flexgem::Comm.get_database
    select_query = "select value from configuration_keys where key = '#{command}' and section =  'flexgem'"
    response = db.get_first_value(select_query)
    unless response.nil?
      return response
    else
      return ""
    end
  end
  
  def self.read_current_value(command)
    db = Flexgem::Comm.get_database
    select_query = "select value from configuration_keys where key = '#{command}' and section =  'current_value'"
    response = db.get_first_value(select_query)
    unless response.nil?
      return response
    else
      return ""
    end
  end
  
#  def self.read_current_value(command)
#    db = Flexgem::Comm.get_database
#    select_query = "select value from configuration_keys where key = '#{command}' and section =  'current_value'"
#    response = db.execute(select_query)
#    unless response.first.nil?
#      return response.first.first
#    else
#      return ""
#    end
#  end
  
end
