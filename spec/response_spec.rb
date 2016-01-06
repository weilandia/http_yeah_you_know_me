require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'

class ResponseTest < Minitest::Test

  attr_reader :ping

  def setup
    @ping = Hurley.get("http://127.0.0.1:9292")
  end

  def test_for_hello_world_in_the_body
    body_split = @ping.body.split
    assert_equal "Hello, World!", body_split[0..1].join(' ')
  end

  def test_url_is_correct
    url = @ping.request.url.to_s
    assert_equal "http://127.0.0.1:9292", url
  end

  def test_verb_is_correct
    verb = @ping.request.verb
    assert_equal :get, verb
  end

  def test_the_server_increments_each_request
    first_time = @ping.body.split[2].gsub(/[()]/, "").to_i
    second_response = Hurley.get("http://127.0.0.1:9292")
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
