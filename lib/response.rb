require 'game'

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

  def start_game
    $game = Game.new
  end

  def guess(request_object)
    params = request_object.request_lines_hash["Guess:"]
    guess = params.split("=")[1]
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
      "Good luck!<p><form action='/start_game' method='post'>
      <input type='Submit' value = 'Start Game!'></input></form></p>"
    elsif hash["Path:"] == "/start_game"
      start_game
      # if @game.exist?
      #   # redirect!!!
      # else
        "Guess a number between 1 and 10:<p><form action='/game' method='post'>
        <input type='textarea' name='guess'></input>
        <input type='Submit'></input></form></p>"
      # end
    elsif hash["Path:"] == "/game"
      guess = guess(request_object)
      $game.guess_tracker(guess)
      "<p>Total guesses so far: #{$game.guess_counter}</p><p>Your last guess was #{$game.last_guess} and #{$game.high_low}</p><form action='/game' method='post'>
      <input type='textarea' name='guess'></input>
      <input type='Submit'></input></form>"
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
