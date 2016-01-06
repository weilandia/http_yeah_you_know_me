require 'socket'
require 'hurley'
require 'request'
require 'request_formatter'
require 'response'

class Server
  attr_reader :port

  def initialize(port = 9292)
    @port = port
    @server = TCPServer.new(9292)
    @total_requests = 0
  end

  def request_response(server = @server)
    while (client = server.accept)

      request_object = Request.new(client, @port)

      request_format =  RequestFormatter.new(request_object).request_format

      Response.new(request_object, request_format, @total_requests)
      @total_requests += 1
      break if request_object.path == "/shutdown"
    end
    client.close
    puts "Total requests: #{@total_requests - 1}"
  end
end
