require 'pi_piper'

reset = PiPiper::Pin.new(:pin => 24, :direction => :out)
dc = PiPiper::Pin.new(:pin => 23, :direction => :out)

reset.on
dc.on

reset.on
sleep(0.001)
reset.off
sleep(0.01)
reset.on

dc.off

def initialize

# """Reset the display."""
# # Set reset high for a millisecond.
# self._gpio.set_high(self._rst)
# time.sleep(0.001)
# # Set reset low for 10 milliseconds.
# self._gpio.set_low(self._rst)
# time.sleep(0.010)
# # Set reset high again.
# self._gpio.set_high(self._rst)

def initialize

  PiPiper::Spi.begin do
    write 0xAE
    write 0xD5
    write 0x80
    write 0x3F
    write 0xD3
    write 0x00
    write 0xA6
    write 0xAF
  end

end
