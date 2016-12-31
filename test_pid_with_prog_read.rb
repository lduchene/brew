#!/usr/bin/env ruby

require_relative 'pid'
require_relative 'temperature.rb'

# very stupid temperature function
def temperature_mock(switch)
	if switch == true
		@temp += 1
	else
		@temp -= 0.3
	end
end

pid = PID.new(1, 0, 0)
temp = Temperature.new(file='temperature_mockfile.txt')
@temp=temp.read
#temp = Temperature.new()
switch = true
t = Time.now.to_f
time = 0
step=0
nstep,target,plateau = pid.read_program(file="Temp_prog",step)

while step<=nstep 
	puts "#{step},#{target},#{plateau}\n"
	pid.set_target(target)
	loop do
		pid_out = pid << @temp
		puts "#{@temp},#{pid_out},#{time}"
		if pid_out > 0
			switch = true
		else
			switch = false
		end
		temperature_mock(switch)
		sleep 0.3
		time = Time.now.to_f - t
		if time > plateau
			step+=1
			break
		end
	end
	old_plateau=plateau
	nstep,target,plateau = pid.read_program(file="Temp_prog",step)
	puts "#{step},#{target},#{plateau}\n"
	plateau+=old_plateau
end
