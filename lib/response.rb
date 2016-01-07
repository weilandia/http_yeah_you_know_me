class Response
  attr_reader :param
  def initialize(request_object, port, total_requests, hello_world_count)
    body = path_finder(request_object, total_requests, hello_world_count)
    response(request_object, port, body)
  end

  def hello_world(hello_world_count)
    "Hello, World! (#{hello_world_count})"
  end

  def shut_it_down(total_requests)
    "Total Requests: (#{total_requests})"
  end

  def datetime
    "#{Time.now.strftime('%l:%M%p')} on  #{Time.now.strftime('%A, %B %e, %Y')}"
  end

  def word_search(request_object)
    if request_object.param_value == nil
      return ""
    else
      word = request_object.param_value.downcase
      if File.read("/usr/share/dict/words").include? "#{word}"
        "#{word.upcase} is a known word"
      else
        "#{word.upcase} is not a known word"
      end
    end
  end

  def path_finder(request_object, total_requests, hello_world_count)
    hash = request_object.request_lines_hash
    if hash["Path:"] == "/hello"
      hello_world(hello_world_count)
    elsif hash["Path:"] == "/shutdown"
      shut_it_down(total_requests)
    elsif hash["Path:"] == "/datetime"
      datetime
    elsif hash["Path:"] == "/word_search"
      word_search(request_object)
    else
      ""
    end
  end

  def response(request_object, port, body)
    request_format = RequestFormatter.new(request_object.request_lines_hash, port).diagnostics
    response = "<pre>" + request_format.join("\n") + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"

    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n"),
              "#{body}"
    request_object.client.puts headers
    request_object.client.puts output
  end

end
