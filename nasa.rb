require "uri"
require "net/http"
require "json"

def request(url,token = nil)
  url = URI("#{url}?sol=1000&#{token}")
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
  request = Net::HTTP::Get.new(url)
  response = https.request(request)
  # puts response.read_body
  JSON.parse(response.read_body)
end


nasa_array = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos","api_key=l8k04BFBf0UF3ZKhzOcth68Be656TWdkOn4f8Pv9")
puts nasa_array