class Request
  attr_reader :verb, :path, :protocol, :port, :request_lines_hash

  def initialize(client, port)
    @port = port

    @request_lines = request(client)

    verb_path_protocol_string

    split_request_lines = split_remaining_request_lines(request_lines_without_verb_path_protocol)

    @request_lines_hash = hash_request_lines(split_request_lines)

    # @request_format = request_format
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
    @path = verb_path_protocol.split[1]
    @protocol = verb_path_protocol.split[2]
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
