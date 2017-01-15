class Temperature
	@@file = nil

	def initialize(file = nil)
		if file == nil
			dir = Dir.glob("/sys/bus/w1/devices/28-*")[0]
			@@file = File.join(dir, "w1_slave")
		else
			@@file = file
		end
	end

	def read
		lines = IO.readlines @@file
		temperature = lines[1].split('=').last.to_f/1000
		temperature
	end

	def is_okay?
		lines = IO.readlines @@file
		if lines[0].include? "YES"
			return true
		else
			return false
		end
	end
end
			
