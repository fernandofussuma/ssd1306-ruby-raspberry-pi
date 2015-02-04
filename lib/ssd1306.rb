require 'pi_piper'

class Ssd1306Spi
  SETCONTRAST = 0x81
  DISPLAYALLON_RESUME = 0xA4
  DISPLAYALLON = 0xA5
  NORMALDISPLAY = 0xA6
  INVERTDISPLAY = 0xA7
  DISPLAYOFF = 0xAE
  DISPLAYON = 0xAF
  SETDISPLAYOFFSET = 0xD3
  SETCOMPINS = 0xDA
  SETVCOMDETECT = 0xDB
  SETDISPLAYCLOCKDIV = 0xD5
  SETPRECHARGE = 0xD9
  SETMULTIPLEX = 0xA8
  SETLOWCOLUMN = 0x00
  SETHIGHCOLUMN = 0x10
  SETSTARTLINE = 0x40
  MEMORYMODE = 0x20
  COLUMNADDR = 0x21
  PAGEADDR = 0x22
  COMSCANINC = 0xC0
  COMSCANDEC = 0xC8
  SEGREMAP = 0xA0
  CHARGEPUMP = 0x8D
  EXTERNALVCC = 0x1
  SWITCHCAPVCC = 0x2

  ACTIVATE_SCROLL = 0x2F
  DEACTIVATE_SCROLL = 0x2E
  SET_VERTICAL_SCROLL_AREA = 0xA3
  RIGHT_HORIZONTAL_SCROLL = 0x26
  LEFT_HORIZONTAL_SCROLL = 0x27
  VERTICAL_AND_RIGHT_HORIZONTAL_SCROLL = 0x29
  VERTICAL_AND_LEFT_HORIZONTAL_SCROLL = 0x2A

  def initialize(pin_reset = 24, pin_dc = 25, width = 128, height = 64)
    @pin_reset = PiPiper::Pin.new(:pin => pin_reset, :direction => :out)
    @pin_dc = PiPiper::Pin.new(:pin => pin_dc, :direction => :out)
    @width = width
    @height = height

    reset()
    configure()
    command(DISPLAYON)
  end

  def write(data)
    @pin_dc.on
    write_spi(data)
  end

  private

  def reset()
    @pin_reset.on
    sleep(0.001)
    @pin_reset.off
    sleep(0.010)
    @pin_reset.on
  end

  def configure()
    command(DISPLAYOFF)
    command(SETDISPLAYCLOCKDIV)
    command(0x80)
    command(SETMULTIPLEX)
    command(0x3F)
    command(SETDISPLAYOFFSET)
    command(0x0)
    command(SETSTARTLINE | 0x0)
    command(CHARGEPUMP)
    command(0x14)
    command(MEMORYMODE)
    command(0x00)
    command(SEGREMAP | 0x1)
    command(COMSCANDEC)
    command(SETCOMPINS)
    command(0x12)
    command(SETCONTRAST)
    command(0xCF)
    command(SETPRECHARGE)
    command(0xF1)
    command(SETVCOMDETECT)
    command(0x40)
    command(DISPLAYALLON_RESUME)
    command(NORMALDISPLAY)
  end

  def command(data)
    @pin_dc.off
    write_spi(data)
  end

  def write_spi(data)
    PiPiper::Spi.begin do
      write data
    end
  end

end
