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

	def <<(input)
		get_output(input)
	end

	def get_output(input)
		error = error(input)
		dt = get_dt
		p = proportional(error)
		i = integrative(error,dt)
		d = derivative(error,dt)
		out = p + i + d
		@previous_error = error
		return out, p, i, d
	end

	private
	
	def error(input)
		input - @target
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
