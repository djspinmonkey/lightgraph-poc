require 'httparty'

class LSPublicAPI
  API_KEY = ENV["LS_TOKEN"]
  BASE_URL = ENV["LS_PUBLICAPI_URL"]

  def self.get(path)
    HTTParty.get("#{BASE_URL}/#{path}", {
      headers: {
        "User-Agent" => "LightGraph POC",
        "Authorization" => API_KEY
      },
      debug_output: STDOUT,
    })['data']
  end
end
