#!/usr/bin/env ruby

require_relative "../pid"

@temp = 0

# very stupid temperature function
def temperature_mock(switch)
	if switch == true
		@temp += 1
	else
		@temp -= 0.3
	end
end

pid = PID.new(1.0, 0.3, 0.1)
pid.set_target(100)

switch = true
t = Time.now.to_f
time = 0
loop do
	pid_out = pid << @temp
	#puts "temperature: #{@temp} (target #{pid.target}) pid : #{pid_out}"
	puts "#{@temp},#{pid_out},#{time}"
	if pid_out > 0
		switch = true
	else
		switch = false
	end
	temperature_mock(switch)
	sleep 0.3
	time = Time.now.to_f - t
	if time > 60
		break
	end
end
