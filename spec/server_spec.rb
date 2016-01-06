require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
class ServerTest < Minitest::Test

  attr_reader :response

  def setup
    @ping = Hurley.get("http://127.0.0.1:9292")
  end

  def test_request_success
    assert @ping.success?
  end
end
