require 'socket'
server = TCPServer.new(9292)
client = server.accept

request_lines = []
while line = client.gets and !line.chomp.empty?
  request_lines << line.chomp
end

response = "<pre>" + request_lines.join("\n") + "</pre>"
output = "<html><head></head><body>#{response}</body></html>"
n = -1
headers = ["http/1.1 200 ok",
          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
          "server: ruby",
          "content-type: text/html; charset=iso-8859-1",
          "content-length: #{output.length}\r\n\r\n"].join("\r\n"),
          "Hello, World! (#{n + 1})"
client.puts headers
client.puts output
