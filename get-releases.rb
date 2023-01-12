require "uri"
require "net/http"
require "json"

# Class that make an http request to "https://api.github.com/repos/ChillyCheesy/Modulo/releases" and return the json response
class GetReleases

    def initialize()
        @uri = URI("https://api.github.com/repos/ChillyCheesy/Modulo/releases")
        @request = Net::HTTP::Get.new(@uri)
        @request["Accept"] = "application/vnd.github.v3+json"
        @request["User-Agent"] = "Ruby"
        @http = Net::HTTP.new(@uri.hostname, @uri.port)
        @http.use_ssl = true
    end

    def get()
        response = @http.request(@request)
        if response.code == "200"
            return JSON.parse(response.read_body).map { |release| release["tag_name"] }
        else
            return nil
        end
    end
end