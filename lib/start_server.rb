$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require 'server'

server = Server.new
server.request_response
