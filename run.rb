require 'csv'
require 'colorize'

require_relative 'switch'
require_relative 'temperature'
require_relative 'pid'

BOILER_SWITCH_PIN  = 25
BOILER_THERMO_FILE = "/sys/bus/w1/devices/28-000005f0e318/w1_slave"
TEMP_FILE = "T_vs_t.csv"
DELAY = 10

@target_temp = 30

@kp = 1.0
@kd = 0.0
@ki = 0.0

pid = PID.new(@kp, @kd, @ki)
thermo = Temperature.new(BOILER_THERMO_FILE)
heater = Switch.new(BOILER_SWITCH_PIN)

CSV.open(TEMP_FILE, "w")

while (true) do
	current_temp = thermo.read
	pid_output = pid << current_temp
	if (pid_output > 0)
		heater.on
	else
		heater.off
	end

	CSV.open(TEMP_FILE, "a") do |csv|
		csv << [Time.now.to_f, thermo.read]
	end

	puts "T: #{thermo.read} time: #{Time.now.to_f} pid: #{pid_output}".green

	sleep(DELAY)

end
