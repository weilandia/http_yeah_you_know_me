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

    verb_path_protocol = request_lines.shift

    verb = verb_path_protocol.split[0]
    path = verb_path_protocol.split[1]
    protocol = verb_path_protocol.split[2]


    request_lines_hash = {}

    request_lines = request_lines.map do |line|
      line.split(" ", 2)
    end

    request_lines = request_lines.map do |line|
      request_lines_hash[line[0]] = line[1]
    end

    request_format = ["Verb: #{verb}",
      "Path: #{path}",
      "Protocol: #{protocol}",
      "Host: #{request_lines_hash["Host:"].split(":")[0]}",
      "Port: #{request_lines_hash["Host:"].split(":")[1]}",
      "Origin: #{request_lines_hash["Host:"].split(":")[0]}",
      "Accept: #{request_lines_hash["Accept:"]}"]
    request_format
  end
end
