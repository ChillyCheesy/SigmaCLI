require "down"
require "fileutils"
require "tty-prompt"

require_relative "./spinner"

DOWNLOAD_URL = "https://github.com/ChillyCheesy/Modulo/releases/download/${version}/modulo-server-${version}.jar"

def download_modulo(version)
    SPINNER.start

    releases = GetReleases.new.get
    if releases.include?(version)
        parsedUrl = DOWNLOAD_URL.gsub("${version}", version)

        tempfile = Down.download(parsedUrl)
        FileUtils.mv(tempfile.path, "./#{tempfile.original_filename}")
        SPINNER.stop("Modulo server successfully downloaded, you can now run it using 'java -jar #{tempfile.original_filename}'")
    else
        SPINNER.stop
        $stdout.clear_screen
        prompt = TTY::Prompt.new

        download_modulo(prompt.select("Which version of Modulo do you want to install ?", releases))
    end
end