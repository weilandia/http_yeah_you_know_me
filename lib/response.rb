require 'socket'
require 'hurley'

class Response

  def initialize(request_format, client, n)
    response(request_format, client, n)
  end

  def response(request_format, client, n)
    response = "<pre>" + request_format.join("\n") + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"

    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n"),
              "Hello, World! (#{n += 1})"
    client.puts headers
    client.puts output
  end
end
