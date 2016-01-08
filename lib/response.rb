require 'game'

class Response
  attr_reader :param, :request_code
  def initialize(request_object, port, total_requests, hello_world_count)
    body = path_finder(request_object, total_requests, hello_world_count)
    response(request_object, port, body)
    @request_code = "200 ok"
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
    if request_object.request_lines_hash["Param_value:"] == nil then ""
    else
      word = request_object.request_lines_hash["Param_value:"].downcase
      if File.read("/usr/share/dict/words").include? "#{word}"
        "#{word.upcase} is a known word"
      else
        "#{word.upcase} is not a known word"
      end
    end
  end

  def start_game
    $game = Game.new
  end

  def guess(request_object)
    params = request_object.request_lines_hash["Guess:"]
    if params == nil then guess = "0"
    else guess = params.split("=")[1] end
  end

  def new_game_message
    "Good luck!<p><form action='/start_game' method='post'>
    <input type='Submit' value = 'Start Game!'></input></form></p>"
  end

  def path_finder(request_object, total_requests, hello_world_count)
    hash = request_object.request_lines_hash
    if hash["Path:"] == "/hello" then hello_world(hello_world_count)
    elsif hash["Path:"] == "/shutdown" then shut_it_down(total_requests)
    elsif hash["Path:"] == "/datetime" then datetime
    elsif hash["Path:"] == "/word_search" then word_search(request_object)
    elsif hash["Path:"] == "/new_game"
      new_game_message
    elsif hash["Path:"] == "/start_game" then start_game && $game.start
    elsif hash["Path:"] == "/game" then $game.guess_tracker(guess(request_object)) && $game.game_path
    elsif hash["Path:"] == "/" then ""
    elsif hash["Path:"] == "/force_error"
      @request_code = "500 Internal Server Error"
    else @request_code = "404 Not Found" end
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
