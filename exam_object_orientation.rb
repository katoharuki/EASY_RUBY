require "net/http"
require "uri"

url = URI.parse("http://www.livedoor.com/")
http = Net::HTTP.start(url.host, url.port)
doc = http.get(url.path)

#puts doc.body
p url.scheme
p url.host
p url.port
p url.to_s
