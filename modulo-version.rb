require "io/console"
require "tty-table"

require_relative "./get-releases"
require_relative "./spinner"

def print_modulo_version
    SPINNER.start

    releases = GetReleases.new
    table = TTY::Table.new header: ["Version"]
    releases.get.each do |release|
        table << [release]
    end

    SPINNER.stop
    $stdout.clear_screen

    puts table.render(:unicode, padding: [0, 1, 0, 1])
end