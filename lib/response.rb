
class Response
  attr_reader :param
  def initialize(request_object, port, total_requests, hello_world_count)
    body = path_finder(request_object, total_requests, hello_world_count)
    response(request_object, port, body)
    puts "\e[35mBODY:\e[32m#{body.inspect}"
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
    if request_object.request_lines_hash["Param_value:"] == nil
      ""
    else
      word = request_object.request_lines_hash["Param_value:"].downcase
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
    elsif hash["Path:"] == "/new_game"
      "Good Luck!\n<form action='/game' method='post'>
      <input type='Submit' value = 'Start Game!'></input></form>"
      #Game.new
    elsif hash["Path:"] == "/game"
      "Guess again!!\n<form action='/game' method='post'>
      <input type='textarea' name='guess'></input>
      <input type='Submit'></input></form>"
      #method that will check the verb
      #if verb == post then take param and compare to answer in Game object
      #if verb == get puts some shit to the screen that queries guess.length
      #have something to prevent bug if no game object exists
    else
      ""
    end
  end

  def response(request_object, port, body)
    request_format = DiagnosticsFormatter.new(request_object.request_lines_hash, port).diagnostics
    diagnostics = request_format.join("\n")
    body_with_diagnostics = body + diagnostics

    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{body_with_diagnostics.length}\r\n\r\n"].join("\r\n"),
              "#{body_with_diagnostics}"
    request_object.client.puts headers
  end

end
