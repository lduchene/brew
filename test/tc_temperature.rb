require_relative '../temperature.rb'
require 'test/unit'

class TestTemperature < Test::Unit::TestCase
	def setup
		@temp = Temperature.new(File.join(File.dirname(__FILE__), 'temperature_mockfile.txt'))
	end

	def test_read
		assert_equal(21.256, @temp.read)
	end

	def test_status
		assert_equal(true, @temp.status)
	end
end	
