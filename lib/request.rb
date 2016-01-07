class Request
  attr_reader :verb, :path, :protocol, :port, :request_lines_hash, :client, :params, :param_value

  def initialize(client, port)
    @client = client
    @port = port
    @request_lines = request(client)
    verb_path_protocol_string
    split_request_lines = split_remaining_request_lines(request_lines_without_verb_path_protocol)
    @request_lines_hash = hash_request_lines(split_request_lines)
    puts "\e[35mREQUEST:\e[31m #{verb.inspect}\e[34m#{path.inspect}\e[33m#{protocol.inspect}"
  end

  def request_lines_without_verb_path_protocol
    @request_lines[1..-1]
  end

  def request(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    request_lines
  end

  def verb_path_protocol_string
    verb_path_protocol = @request_lines[0]
    @verb = verb_path_protocol.split[0]
    @path = verb_path_protocol.split[1].split("?")[0]
    @params = verb_path_protocol.split[1].split("?")[1]
    @protocol = verb_path_protocol.split[2]
  end
  
  def param_value
    @params.split("=")[1]
  end

  def split_remaining_request_lines(request_lines)
    request_lines = request_lines.map do |line|
      line.split(" ", 2)
    end
  end

  def hash_request_lines(request_lines)
    request_lines_hash = {}
    request_lines_hash["Verb:"] = @verb
    request_lines_hash["Path:"] = @path
    request_lines_hash["Protocol:"] = @protocol
    request_lines = request_lines.map do |line|
      request_lines_hash[line[0]] = line[1]
    end
    request_lines_hash
  end
end
