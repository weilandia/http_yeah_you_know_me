class Response

  def initialize(request_object, request_format, client, n)
    body = path_finder(request_object, n)
    response(request_format, client, body, n)
  end

  def path_finder(request_object, n)
    hash = request_object.request_lines_hash
    if hash["Path:"] == "/hello"
      body = "Hello, World! (#{n += 1})"
    else
      body = ""
    end
  end

  def response(request_format, client, body, n)
    response = "<pre>" + request_format.join("\n") + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"

    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n"),
              "#{body}"
    client.puts headers
    client.puts output
  end
end
