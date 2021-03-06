module Flexgem
	require 'serialport'
	require 'flexgem/comm'
	require 'flexgem/modulator'
	require 'flexgem/rds'
	require 'flexgem/system'
	require 'flexgem/comparator'
	require 'flexgem/db'
	require 'flexgem/power_system'
	require 'sqlite3'
	require 'logger'
	
	
	
	
	def self.send_command(command,*params)
		command = command.upcase
		puts "parameter = "+params.join(", ")
		params = params.select {|param| !param.empty? }
		puts "Mando parametri #{params}"
		response = Comm.submit_command(command,*params)
	
		return response
	end
end
