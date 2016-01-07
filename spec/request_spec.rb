require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/request'
require_relative '../spec/test_helper'

class RequestTest < Minitest::Test

  def test_for_a_verb_in_request
    request = Request.new(MyClient.new)
    assert_equal "GET", request.verb
  end

  def test_for_a_path_in_request
    request = Request.new(MyClient.new)
    assert_equal "/", request.path
  end

  def test_for_a_protocol_in_request
    request = Request.new(MyClient.new)
    assert_equal "HTTP/1.1", request.protocol
  end

  def test_a_key_can_be_called_and_a_value_returned
    request = Request.new(MyClient.new)
    assert_equal "en-US,en;q=0.8", request.request_lines_hash["Accept-Language:"]
  end

  def test_for_path_in_request_object
    request = Request.new(MyParamClient.new)
    assert_equal "/word_search", request.path
  end

  def test_for_params_in_request_object
    request = Request.new(MyParamClient.new)
    assert_equal "word=hat",
    request.params
  end

  def test_for_param_value_in_request_object
    request = Request.new(MyParamClient.new)
    assert_equal "hat",
    request.param_value
  end

end
