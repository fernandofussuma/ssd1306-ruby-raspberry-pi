require 'pi_piper'

pin = PiPiper::Pin.new(:pin => 24, :direction => :out)

while (true)
  pin.on
  sleep(100)
  pin.off
  sleep(100)
end
