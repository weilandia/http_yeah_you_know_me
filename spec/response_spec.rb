require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
require 'server'


class ResponseTest < Minitest::Test

  attr_reader :ping

  def setup
    @ping = Hurley.get("http://127.0.0.1:9292")
    @post_ping = Hurley.post("http://127.0.0.1:9292/start_game")
  end

  def test_for_hello_world_in_the_body
    ping = Hurley.get("http://127.0.0.1:9292/hello")
    body_split = ping.body.split
    assert_equal "Hello, World!", body_split[0..1].join(' ')
  end

  def test_for_datetime_in_the_body
    ping = Hurley.get("http://127.0.0.1:9292/datetime")
    body_split = ping.body.split('<')
    assert_equal "#{Time.now.strftime('%l:%M%p')} on  #{Time.now.strftime('%A, %B %e, %Y')}", body_split[0]
  end

  def test_for_shut_it_down
    ping = Hurley.get("http://127.0.0.1:9293")
    assert ping.success?
    ping = Hurley.get("http://127.0.0.1:9293/shutdown")
    assert_equal "Total Requests: (1)", ping.body[0..18]
    assert_raises(*"Connection refused") { Hurley.get("http://127.0.0.1:9293").success? }
  end
  #
  def test_for_no_body_with_no_path
    ping = Hurley.get("http://127.0.0.1:9292")
    assert_equal "<pre>Verb: GET", ping.body.split("\n")[0]
  end

  def test_for_a_known_word
    ping = Hurley.get("http://127.0.0.1:9292/word_search?word=dog")
    body_split = ping.body.split("<")
    assert_equal "DOG is a known word", body_split[0]
  end

  def test_for_a_unknown_word
    ping = Hurley.get("http://127.0.0.1:9292/word_search?word=asdlfk")
    body_split = ping.body.split("<")
    assert_equal "ASDLFK is not a known word", body_split[0]
  end


  def test_url_is_correct
    url = @ping.request.url.to_s
    assert_equal "http://127.0.0.1:9292", url
  end

  def test_get_verb_is_correct
    verb = @ping.request.verb
    assert_equal :get, verb
  end

  def test_post_verb_is_correct
    verb = @post_ping.request.verb
    assert_equal :post, verb
  end

  def test_500_response_code
    ping = Hurley.get("http://127.0.0.1:9292/force_error")
    body_split = ping.body.split("<")[0]
    assert_equal "500 Internal Server Error", body_split
  end

  def test_error_response_code
    ping = Hurley.get("http://127.0.0.1:9292/asdf")
    body_split = ping.body.split("<")[0]
    assert_equal "404 Not Found", body_split
  end

  def test_the_server_increments_each_request
    ping = Hurley.get("http://127.0.0.1:9292/hello")
    first_time = ping.body.split[2].gsub(/[()]/, "").to_i
    second_response = Hurley.get("http://127.0.0.1:9292/hello")
    second_time = second_response.body.split[2].gsub(/[()]/, "").to_i
    assert_equal second_time, first_time + 1
  end

  def test_server_is_ruby
    assert_equal "ruby", @ping.header["Server"]
  end

  def test_content_type
    assert_equal "text/html; charset=iso-8859-1", @ping.header["Content-Type"]
  end

end
