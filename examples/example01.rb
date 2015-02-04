require 'pi_piper'

# CONSTANTS
SSD1306_SETCONTRAST = 0x81
SSD1306_DISPLAYALLON_RESUME = 0xA4
SSD1306_DISPLAYALLON = 0xA5
SSD1306_NORMALDISPLAY = 0xA6
SSD1306_INVERTDISPLAY = 0xA7
SSD1306_DISPLAYOFF = 0xAE
SSD1306_DISPLAYON = 0xAF
SSD1306_SETDISPLAYOFFSET = 0xD3
SSD1306_SETCOMPINS = 0xDA
SSD1306_SETVCOMDETECT = 0xDB
SSD1306_SETDISPLAYCLOCKDIV = 0xD5
SSD1306_SETPRECHARGE = 0xD9
SSD1306_SETMULTIPLEX = 0xA8
SSD1306_SETLOWCOLUMN = 0x00
SSD1306_SETHIGHCOLUMN = 0x10
SSD1306_SETSTARTLINE = 0x40
SSD1306_MEMORYMODE = 0x20
SSD1306_COLUMNADDR = 0x21
SSD1306_PAGEADDR = 0x22
SSD1306_COMSCANINC = 0xC0
SSD1306_COMSCANDEC = 0xC8
SSD1306_SEGREMAP = 0xA0
SSD1306_CHARGEPUMP = 0x8D
SSD1306_EXTERNALVCC = 0x1
SSD1306_SWITCHCAPVCC = 0x2

# SCROLLING CONSTANTS
SSD1306_ACTIVATE_SCROLL = 0x2F
SSD1306_DEACTIVATE_SCROLL = 0x2E
SSD1306_SET_VERTICAL_SCROLL_AREA = 0xA3
SSD1306_RIGHT_HORIZONTAL_SCROLL = 0x26
SSD1306_LEFT_HORIZONTAL_SCROLL = 0x27
SSD1306_VERTICAL_AND_RIGHT_HORIZONTAL_SCROLL = 0x29
SSD1306_VERTICAL_AND_LEFT_HORIZONTAL_SCROLL = 0x2A

reset = PiPiper::Pin.new(:pin => 24, :direction => :out)
dc = PiPiper::Pin.new(:pin => 23, :direction => :out)

def reset_ssd1306(reset)
  reset.on
  sleep(0.001)
  reset.off
  sleep(0.01)
  reset.on
end

def command(dc, data)
  dc.off
  PiPiper::Spi.begin do
    write data
  end
end

def write(dc, data)
  dc.on
  PiPiper::Spi.begin do
    write data
  end
end

def start(dc)
    # 128x64 pixel specific initialization.
    command(dc, SSD1306_DISPLAYOFF)                    # 0xAE
    command(dc, SSD1306_SETDISPLAYCLOCKDIV)            # 0xD5
    command(dc, 0x80)                                  # the suggested ratio 0x80
    command(dc, SSD1306_SETMULTIPLEX)                  # 0xA8
    command(dc, 0x3F)
    command(dc, SSD1306_SETDISPLAYOFFSET)              # 0xD3
    command(dc, 0x0)                                   # no offset
    command(dc, SSD1306_SETSTARTLINE | 0x0)            # line #0
    command(dc, SSD1306_CHARGEPUMP)                    # 0x8D
    command(dc, 0x14)
    command(dc, SSD1306_MEMORYMODE)                    # 0x20
    command(dc, 0x00)                                  # 0x0 act like ks0108
    command(dc, SSD1306_SEGREMAP | 0x1)
    command(dc, SSD1306_COMSCANDEC)
    command(dc, SSD1306_SETCOMPINS)                    # 0xDA
    command(dc, 0x12)
    command(dc, SSD1306_SETCONTRAST)                   # 0x81
    command(dc, 0xCF)
    command(dc, SSD1306_SETPRECHARGE)                  # 0xd9
    command(dc, 0xF1)
    command(dc, SSD1306_SETVCOMDETECT)                 # 0xDB
    command(dc, 0x40)
    command(dc, SSD1306_DISPLAYALLON_RESUME)           # 0xA4
    command(dc, SSD1306_NORMALDISPLAY)                 # 0xA6
end

reset_ssd1306(reset)
start(dc)
command(dc, SSD1306_DISPLAYON)

sleep(0.1)

write(dc, 0x00)

