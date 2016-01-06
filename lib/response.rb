class Response

  def initialize(request_object, request_format, n)
    body = path_finder(request_object, n)
    response(request_format, request_object.client, body, n)
  end

  def hello_world(n)
    "Hello, World! (#{n})"
  end

  def shut_it_down(n)
    "Total Requests: (#{n})"
  end

  def path_finder(request_object, n)
    hash = request_object.request_lines_hash
    if hash["Path:"] == "/hello"
      hello_world(n)
    elsif hash["Path:"] == "/shutdown"
      shut_it_down(n)
    else
      ""
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
