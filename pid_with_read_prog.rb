#!/usr/bin/env ruby

class PID
	attr_accessor :kp, :ki, :kd, :target

	def initialize(kp, ki, kd)
		@kp = kp
		@ki = ki
		@kd = kd
		@integral = 0.0
		@previous_error = 0.0
		@last_time = nil
		
	end

	public

	def set_target(target)
		@target = target
	end

	def read_program(file="Temp_prog",step)
		@@file=file
		lines = IO.readlines @@file
		nstep=lines[1].to_i
		if step==0
			target=lines[3].to_i
			plateau=10 #ramp for 2h max (faut pas exagérer non plus)
		else
			target,plateau=lines[step+4].split(",",2)
		end
		return nstep,target.to_i,plateau.to_i
	end
	
	def <<(input)
		get_output(input)
	end
	def get_output(input)
		error = error(input)
		dt = get_dt
		out = proportional(error) + integrative(error, dt) + derivative(error, dt)
		@previous_error = error
		return out	
	end


	private
	
	def error(input)
		@target - input
	end

	def get_dt
		t = Time.now.to_f
		if @last_time.nil?
			dt = 1.0
		else
			dt = t - @last_time
		end
		@last_time = t
		return dt
	end

	def proportional(error)
		@kp*error	
	end

	def integrative(error, dt)
		@integral = @integral + @ki*error*dt
		return @integral
	end

	def derivative(error, dt)
		out = @kd*(error-@previous_error)/dt
		return out
	end
	
end
