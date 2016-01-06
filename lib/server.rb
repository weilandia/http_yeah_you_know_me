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
    @n = -1
  end

  def request_response(server = @server)
    while (client = server.accept)

      request_format =  RequestFormatter.new(Request.new(client)).request_format

      Response.new(request_format, client, @n)
      @n += 1
    end
  end
end
