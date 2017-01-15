#!/usr/bin/env ruby


class PidController
	def initialize(kp, ki, kd, target, thermo, switch, delay=1.0)
		@pid = PID.new(kp, ki, kd)
		@thermo = thermo
		@switch = switch
		@delay = delay	
		@target = target
	end

	def control_loop
		@pid.set_target(@target)
		while(true) do
			temp = @thermo.read
			pid_out,p,i,d = @pid << temp
			if(pid_out > 0)
				@switch.on
			else
				@switch.off
			end
			sleep(@delay)
		end
	end

	def start
		@thread = Thread.new do
			control_loop
		end
		@thread.join
	end
	
	def stop
		@thread.exit
		@switch.off
	end

	def set_target(temperature)
		@pid.set_target(temperature)
	end

	def set_params(kp, ki, kd)
		stop
		@pid = PID.new(kp, ki, kd)
		start
	end

end
