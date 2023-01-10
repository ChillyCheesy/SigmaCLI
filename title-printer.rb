require 'colorize'

class Title
    attr_accessor :lines

    def initialize(lines=[
        "   ______ ",
        "   \\  ___) _                              ",
        "    \\ \\   (_)  __ _  _ __ ___    __ _     ",
        "     > >  | | / _` || '_ ` _ \\  / _` |    ",
        "    / /__ | || (_| || | | | | || (_| |    ",
        "   /_____)|_| \\__, ||_| |_| |_| \\__,_|    ",
        "              |___/                       ",
        "                                  A Modulo CLI"
        ])
        @lines = lines
    end

    def print_title
        lines.each do |line|
            puts line.colorize(:color => :magenta)
        end
    end
end