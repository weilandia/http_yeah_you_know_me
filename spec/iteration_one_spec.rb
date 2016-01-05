require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
require 'pry'
class IterartionZeroTest < Minitest::Test

  attr_reader :response

  def setup
    @response = Hurley.get("http://127.0.0.1:9292")
  end

  def test_response_success
    assert response.success?
  end

  def test_verb_format_in_request
    response.body = response.body.gsub!(/(<[^>]*>)|\n|\t/s) {" "}
    response_body = response.body.split
    assert_equal "Verb: GET", response_body[3..4].join(' ')
  end

  def test_path_format_in_request
    response.body = response.body.gsub!(/(<[^>]*>)|\n|\t/s) {" "}
    response_body = response.body.split
    assert_equal "Path: /", response_body[5..6].join(' ')
  end

  def test_protocol_format_in_request
    response.body = response.body.gsub!(/(<[^>]*>)|\n|\t/s) {" "}
    response_body = response.body.split
    assert_equal "Protocol: HTTP/1.1", response_body[7..8].join(' ')
  end

  def test_url_is_correct
    url = response.request.url.to_s
    assert_equal "http://127.0.0.1:9292", url
  end

  def test_verb_is_correct
    verb = response.request.verb
    assert_equal :get, verb
  end

  def test_the_server_increments_each_request
    first_time = response.body.split[2].gsub(/[()]/, "").to_i
    second_response = Hurley.get("http://127.0.0.1:9292")
    second_time = second_response.body.split[2].gsub(/[()]/, "").to_i
    assert_equal second_time, first_time + 1
  end

  def test_server_is_ruby
    assert_equal "ruby", response.header["Server"]
  end

  def test_content_type
    assert_equal "text/html; charset=iso-8859-1", response.header["Content-Type"]
  end
end
