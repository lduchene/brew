require 'wiringpi'

class Stepper
	def initialize(pin_a1, pin_a2, pin_b1, pin_b2, gpio=nil)
		if gpio.nil?
			@gpio = WiringPi::GPIO.new
		else
			@gpio = gpio
		end
		@pins = [pin_a1, pin_a2, pin_b1, pin_b2]
		@phase_seq = [[1,0,0,0],[1,1,0,0],[0,1,0,0],[0,1,1,0],[0,0,1,0],[0,0,1,1],[0,0,0,1],[1,0,0,1]]	
	
		@pins.each  do |pin|
			@gpio.pin_mode(pin, WiringPi::OUTPUT)
			@gpio.digital_write(pin, WiringPi::LOW)
		end
	end

	def rotate(steps, delay=0.05)
		# the sign of steps determines the direction
		if (steps < 0)
			phases = @phase_seq.reverse
		else
			phases = @phase_seq
		end
		l = phases.length
		(0..steps.abs).each do |s|
			puts " * step: #{s}"
			phase_idx = s % l
			(0..3).each do |i|
				puts "pin: #{@pins[i]}, value: #{phases[phase_idx][i]}" 
				@gpio.digital_write(@pins[i], phases[phase_idx][i])
			end
			sleep(delay)
		end
		release_pins
	end

	def release_pins
		@pins.each do |pin|
			@gpio.digital_write(pin, WiringPi::LOW)
		end
	end
end
