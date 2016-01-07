require 'minitest/autorun'
require 'minitest/pride'
require 'request_formatter'
require 'request'
require 'test_helper'

class RequestFormatterTest < Minitest::Test

  def test_we_can_pass_in_request_object
    request = Request.new(MyClient.new)
    formatter = RequestFormatter.new(request.request_lines_hash, 9292)
    assert_equal RequestFormatter, formatter.class
  end

  def test_verb_format
    request = Request.new(MyClient.new)
    formatter = RequestFormatter.new(request.request_lines_hash, 9292)
    assert_equal "Verb: GET", formatter.diagnostics[0]
  end

  def test_path_format
    request = Request.new(MyClient.new)
    formatter = RequestFormatter.new(request.request_lines_hash, 9292)
    assert_equal "Path: /", formatter.diagnostics[1]
  end

  def test_protocol_format
    request = Request.new(MyClient.new)
    formatter = RequestFormatter.new(request.request_lines_hash, 9292)
    assert_equal "Protocol: HTTP/1.1", formatter.diagnostics[2]
  end

  def test_host_format
    request = Request.new(MyClient.new)
    formatter = RequestFormatter.new(request.request_lines_hash, 9292)
    assert_equal "Host: 127.0.0.1", formatter.diagnostics[3]
  end

  def test_port_format
    request = Request.new(MyClient.new)
    formatter = RequestFormatter.new(request.request_lines_hash, 9292)
    assert_equal "Port: 9292", formatter.diagnostics[4]
  end

  def test_port_format
    request = Request.new(MyClient.new)
    formatter = RequestFormatter.new(request.request_lines_hash, 9292)
    assert_equal "Port: 9292", formatter.diagnostics[4]
  end

  def test_origin_format
    request = Request.new(MyClient.new)
    formatter = RequestFormatter.new(request.request_lines_hash, 9292)
    assert_equal "Origin: 127.0.0.1", formatter.diagnostics[5]
  end

  def test_accept_format
    request = Request.new(MyClient.new)
    formatter = RequestFormatter.new(request.request_lines_hash, 9292)
    assert_equal "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", formatter.diagnostics[6]
  end
end
