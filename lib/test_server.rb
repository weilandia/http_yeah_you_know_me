$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require 'server'

test_server = Server.new(9293)
test_server.request_response
