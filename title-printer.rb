require 'colorize'


LINES = [
    "   ______ ",
    "   \\  ___) _                              ",
    "    \\ \\   (_)  __ _  _ __ ___    __ _     ",
    "     > >  | | / _` || '_ ` _ \\  / _` |    ",
    "    / /__ | || (_| || | | | | || (_| |    ",
    "   /_____)|_| \\__, ||_| |_| |_| \\__,_|    ",
    "              |___/                       ",
    " Allons-y !          -          A Modulo CLI",
    ""
]

def print_title
    LINES.each do |line|
        puts line.colorize(:color => :magenta)
    end
end