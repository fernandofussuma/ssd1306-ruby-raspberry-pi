require 'pi_piper'

pin = PiPiper::Pin.new(:pin => 24, :direction => :out)

pin.on
