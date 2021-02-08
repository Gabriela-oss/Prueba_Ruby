require "uri"
require "net/http"
require "json"

def request(url,token = nil)
  url = URI("#{url}?sol=1000&api_key=#{token}")
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
  request = Net::HTTP::Get.new(url)
  response = https.request(request)
  # puts response.read_body
  JSON.parse(response.read_body)
end


#index HTML
def buid_web_page(info_hash)
  File.open('appod_index.html','w') do |file|
    photos = info_hash["photos"]
    file.puts "<html>"
    file.puts "<head>"
    file.puts "</head>"
    file.puts "<body>"
    file.puts "<ul>"
    photos.each do |photo|
      file.puts "<li><img src='#{photo["img_src"]}'></li>"
    end 
    file.puts "</ul>"
    file.puts "</body>"
    file.puts "</html>"
  end
end

def photos_count(info_hash)
    photos = {}
    info_hash['photos'].each  do |photo|
      camera = photo['camera']['name']
      if photos[camera]
        photos[camera] += 1 
      else 
        photos[camera] = 1 
      end 
    end 
    photos 
end 
nasa_array = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos","l8k04BFBf0UF3ZKhzOcth68Be656TWdkOn4f8Pv9")
puts photos_count(nasa_array)
buid_web_page(nasa_array)
