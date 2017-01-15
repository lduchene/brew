require 'wiringpi'

class Switch
	def initialize(pin, gpio=nil)
		if gpio.nil?
			@gpio = WiringPi::GPIO.new
		else
			@gpio = gpio
		end
		@pin = pin
		@gpio.pin_mode(pin, WiringPi::OUTPUT)
		@gpio.digital_write(@pin, 0)
		@status = 0		
	end

	def on
		@gpio.digital_write(@pin, 1)
		@status = 1
	end

	def off
		@gpio.digital_write(@pin, 0)
		@status = 0
	end

	def toggle
		if (@status == 1)
			off
		else
			on
		end
	end
end

