module Flexgem::Rds

   @rds_text_command = "RDS_TEXT"
   @rds_name_command = "RDS_NAME"
   @rds_tr_program_command = "RDS_TRPROGRAM"
   @rds_tr_alert_command = "RDS_TRALERT"
   @rds_alt_freq_command = "RDS_ALTFREQ"
   @rds_music_speech_command = "RDS_MUSICSPEECH"
   @rds_prog_id_command = "RDS_PROGID"
   @rds_prog_type_command = "RDS_PROGTYPE"

	def self.read_rds_text
		command = @rds_text_command
		response = Flexgem::Comm.submit_command(command)
		response["values"].first
	end
	
	def self.write_rds_text(rds_text)
		command = @rds_text_command
		rds_text = "\"#{rds_text}\""
		response = Flexgem::Comm.submit_command(command,rds_text)
		return response["result_code"] == '0'
	end
	
	def self.read_rds_name
		command = @rds_name_command
		response = Flexgem::Comm.submit_command(command)
		response["values"].first
	end
	
	def self.write_rds_name(rds_name)
		command = @rds_name_command
		rds_name = "\"#{rds_name}\""
		response = Flexgem::Comm.submit_command(command,rds_name)
		return response["result_code"] == '0'
	end
	
	def self.read_rds_tr_program
		command = @rds_tr_program_command
		response = Flexgem::Comm.submit_command(command)
		response["values"].first
	end
	
	def self.write_rds_tr_program(rds_tr_program)
		command = @rds_tr_program_command
		response = Flexgem::Comm.submit_command(command,rds_tr_program)
		return response["result_code"] == '0'
	end
	
	def self.read_rds_tr_alert
		command = @rds_tr_alert_command
		response = Flexgem::Comm.submit_command(command)
		response["values"].first
	end
	
	def self.write_rds_tr_alert(rds_tr_alert)
		command = @rds_tr_alert_command
		response = Flexgem::Comm.submit_command(command,rds_tr_alert)
		return response["result_code"] == '0'
	end
	
	def self.read_rds_music_speech
		command = @rds_music_speech_command
		response = Flexgem::Comm.submit_command(command)
		response["values"].first
	end
	
	def self.write_rds_music_speech(rds_music_speech)
		command = @rds_music_speech_command
		response = Flexgem::Comm.submit_command(command,rds_music_speech)
		return response["result_code"] == '0'
	end
	
	def self.read_rds_prog_id
		command = @rds_prog_id_command
		response = Flexgem::Comm.submit_command(command)
		response["values"].first
	end
	
	def self.write_rds_prog_id(rds_prog_id)
		command = @rds_prog_id_command
		response = Flexgem::Comm.submit_command(command,rds_prog_id)
		return response["result_code"] == '0'
	end
	
	def self.read_rds_prog_type
		command = @rds_prog_type_command
		response = Flexgem::Comm.submit_command(command)
		response["values"].first
	end
	
	def self.write_rds_prog_type(rds_prog_type)
		command = @rds_prog_type_command
		response = Flexgem::Comm.submit_command(command,rds_prog_type)
		return response["result_code"] == '0'
	end
	
	def self.read_rds_alt_freqs
		command = @rds_alt_freq_command
		response = Flexgem::Comm.submit_command(command)
		response["values"].drop(2)
	end
	
	def self.write_rds_alt_freqs(*rds_alt_freqs)
		command = @rds_alt_freq_command
		rds_alt_freqs = rds_alt_freqs.reject { |freq| freq.empty? }
		response = Flexgem::Comm.submit_command(command,rds_alt_freqs)
		return response["result_code"] == '0'
	end
end
