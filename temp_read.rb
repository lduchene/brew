class Class
  
  def read(step)
    puts "To stop press q + enter (will end automatically after 30 seconds)"
    stop=0
    Thread.new do
      loop do
        if gets.chomp == 'q' 
          stop=1
        end
      end
    end
  
    time=0
    temp_all=[]
    seconds=[]
    start=Time.now
    until (stop==1 || time>=30.0) do
      lines=IO.readlines("w1_slave.txt")
      temp=lines[1].split('=').last.to_f/1000
      temp_all<<temp
      time=Time.now-start
      seconds<<time
      puts "T="+temp.to_s+"°C at "+time.to_s+ " seconds"
      sleep step
    end 
  end
end

class Temperature 

end

puts "Read temperature every ? seconds"
step=gets.chomp.to_i 
Temperature.read(step)
