
require 'sinatra'
require_relative 'temperature'

thermo = Temperature.new('test/temperature_mockfile.txt')

get '/' do
	temp = thermo.read()
	"The temperature is: #{temp}"	
end

get '/temp' do
	"#{thermo.read()}"
end


