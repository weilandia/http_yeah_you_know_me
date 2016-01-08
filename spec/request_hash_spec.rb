require 'minitest/autorun'  # => true
require 'minitest/pride'    # => true
require 'request_hash'      # ~> LoadError: cannot load such file -- request_hash
require 'request'
require 'test_helper'

class RequestHashTest < Minitest::Test

  def test_for_a_verb_in_request
    request = Request.new(MyClient.new)
    assert_equal "GET", request.request_lines_hash["Verb:"]
  end

  def test_for_a_path_in_request
    request = Request.new(MyClient.new)
    assert_equal "/", request.request_lines_hash["Path:"]
  end

  def test_for_a_protocol_in_request
    request = Request.new(MyClient.new)
    assert_equal "HTTP/1.1", request.request_lines_hash["Protocol:"]
  end

  def test_a_key_can_be_called_and_a_value_returned
    request = Request.new(MyClient.new)
    assert_equal "en-US,en;q=0.8", request.request_lines_hash["Accept-Language:"]
  end

  def test_for_path_in_request_object
    request = Request.new(MyParamClient.new)
    assert_equal "/word_search", request.request_lines_hash["Path:"]
  end

  def test_for_params_in_request_object
    request = Request.new(MyParamClient.new)
    assert_equal "word=hat",
    request.request_lines_hash["Params:"]
  end

  def test_for_param_value_in_request_object
    request = Request.new(MyParamClient.new)
    assert_equal "hat",
    request.request_lines_hash["Param_value:"]
  end
end

# >> Run options: --seed 48946
# >>
# >> # Running:
# >>
# >>
# >>
# >> Finished in 0.000769s, 0.0000 runs/s, 0.0000 assertions/s.
# >>
# >> 0 runs, 0 assertions, 0 failures, 0 errors, 0 skips

# ~> LoadError
# ~> cannot load such file -- request_hash
# ~>
# ~> /Users/adamhundley/.rvm/rubies/ruby-2.2.1/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
# ~> /Users/adamhundley/.rvm/rubies/ruby-2.2.1/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
# ~> /Users/adamhundley/Turing/1module/Projects/http_yeah_you_know_me/spec/request_hash_spec.rb:3:in `<main>'
