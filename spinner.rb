require "tty-spinner"

class Spinner

    def initialize(format=:classic)
        @spinner = TTY::Spinner.new("[:spinner] Downloading ...", format: format)
    end

    def start
        @spinner.auto_spin
    end

    def stop(message="Done!")
        @spinner.stop(message)
    end

end