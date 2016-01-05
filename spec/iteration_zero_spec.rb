require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'

class IterartionZeroTest < Minitest::Test

  attr_reader :response

  def setup
    @response = Hurley.get("http://127.0.0.1:9292")
  end

  def test_response_success
    assert response.success?
  end

  def test_for_a_body
    body_split = response.body.split
    assert_equal "Hello,", body_split[0]
  end

  def test_for_the_url
    url = response.request.url.to_s
    assert_equal "http://127.0.0.1:9292", url
  end

  def test_for_the_verb
    verb = response.request.verb
    assert_equal :get, verb
  end

  def test_the_server_increments_each_request
    first_time = response.body.split[2].split("")[1..2].join.to_i
    second_response = Hurley.get("http://127.0.0.1:9292")
    second_time = second_response.body.split[2].split("")[1..2].join.to_i
    assert_equal second_time, first_time + 1
  end


end
