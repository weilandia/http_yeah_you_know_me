require 'socket'
require 'hurley'

class Request
  attr_reader :request_format

  def initialize(client)
    request_format = request(client)
    @request_format = request_format
  end

  def request(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end

    verb = request_lines[0].split[0]
    path = request_lines[0].split[1]
    protocol = request_lines[0].split[2]
    host = request_lines[1].split(":")[1].strip
    port = request_lines[1].split(":").last
    accept = request_lines[4].split(":")[1].strip

    request_format = ["Verb: #{verb}",
      "Path: #{path}",
      "Protocol: #{protocol}",
      "Host: #{host}",
      "Port: #{port}",
      "Origin: #{host}",
      "Accept: #{accept}"]
    request_format
  end
end
