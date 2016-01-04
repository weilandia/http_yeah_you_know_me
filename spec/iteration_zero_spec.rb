require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'

class IterartionZeroTest < Minitest::Test

  attr_reader :client, :iterator

  def setup
    @client = Hurley::Client.new("http://127.0.0.1:9292")
    @iterator = 0
  end

  def test_response_success
    response = Hurley.get("http://127.0.0.1:9292")
    assert response.success?
  end

end
