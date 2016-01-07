require 'request_hash'
class Request
  attr_reader :request_lines_hash, :client

  def initialize(client)
    @client = client
    @request_lines = request(client)
    # @request_lines_hash = RequestHash.new(request(client))
    @request_lines_hash = hash_request_lines(@request_lines[1..-1])
    puts "\e[35mREQUEST:\e[31m #{verb.inspect}\e[34m#{path.inspect}\e[33m#{protocol.inspect}"
  end

  def request(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    request_lines
  end

  def verb
    @request_lines[0].split[0]
  end

  def path
    @request_lines[0].split[1].split("?")[0]
  end

  def protocol
    @request_lines[0].split[2]
  end

  def params
    @request_lines[0].split[1].split("?")[1]
  end

  def param_value
    params.split("=")[1]
  end

  def hash_request_lines(request_lines)
    request_lines = split_remaining_request_lines(request_lines)
    request_lines_hash = {}
    request_lines_hash["Verb:"] = verb
    request_lines_hash["Path:"] = path
    request_lines_hash["Protocol:"] = protocol
    request_lines = request_lines.map do |line|
      request_lines_hash[line[0]] = line[1]
    end
    request_lines_hash
  end

  def split_remaining_request_lines(request_lines)
    request_lines = request_lines.map do |line|
      line.split(" ", 2)
    end
  end
end
