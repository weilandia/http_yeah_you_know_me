require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
require 'request'
require 'test_helper'

class RequestTest < Minitest::Test

  def test_for_a_verb_in_request
    request = Request.new(MyClient.new).verb
    assert_equal "GET", request
  end

  def test_for_a_path_in_request
    request = Request.new(MyClient.new).path
    assert_equal "/", request
  end

  def test_for_a_protocol_in_request
    request = Request.new(MyClient.new).protocol
    assert_equal "HTTP/1.1", request
  end

  def test_splitting_remaining_lines
    request = Request.new(MyClient.new)

    expectation = [["Host:", "127.0.0.1:9292"], ["Connection:", "keep-alive"], ["Cache-Control:", "max-age=0"], ["Accept:", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"], ["Upgrade-Insecure-Requests:", "1"], ["User-Agent:", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36"], ["Accept-Encoding:", "gzip, deflate, sdch"], ["Accept-Language:", "en-US,en;q=0.8"]]
    assert_equal expectation, request.split_remaining_request_lines(request.request_lines_without_verb_path_protocol)
  end

  def test_hash_is_created
    request = Request.new(MyClient.new)
    request_hash = request.hash_request_lines(request.request_lines_without_verb_path_protocol)
    assert_equal Hash, request_hash.class
  end

  def test_a_key_can_be_called_and_a_value_returned
    request = Request.new(MyClient.new)
    assert_equal "en-US,en;q=0.8", request.request_lines_hash["Accept-Language:"]
  end
#
#   def test_protocol_format_in_request
#     ping.body = ping.body.gsub!(/(<[^>]*>)|\n|\t/s) {" "}
#     response_body = ping.body.split
#     assert_equal "Protocol: HTTP/1.1", response_body[7..8].join(' ')
#   end
#
#   def test_host_format_in_request
#     ping.body = ping.body.gsub!(/(<[^>]*>)|\n|\t/s) {" "}
#     response_body = ping.body.split
#     assert_equal "Host 127.0.0.1", response_body[9..10].join(' ')
#   end
#
end
