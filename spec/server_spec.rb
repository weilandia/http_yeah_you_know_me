require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
class ServerTest < Minitest::Test

  attr_reader :response

  def setup
    @response = Hurley.get("http://127.0.0.1:9292")
  end
end
