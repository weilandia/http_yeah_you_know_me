class RequestHash
  attr_reader :hash
  def initialize(request_lines)
    @request_lines = request_lines
    @hash = hash_request_lines(request_lines[1..-1])
    puts "\e[35mREQUEST:\e[31m #{verb.inspect}\e[34m#{path.inspect}\e[33m#{protocol.inspect}\e\n[32mParameters = #{params.inspect}\nHost = #{hash["Host:"].inspect}\nAccept = #{hash["Accept:"].inspect}"
  end

  def hash_request_lines(request_lines)
    request_lines = split_remaining_request_lines(request_lines)
    request_lines_hash = {}
    request_lines_hash["Verb:"] = verb
    request_lines_hash["Path:"] = path
    request_lines_hash["Protocol:"] = protocol
    request_lines_hash["Params:"] = params
    request_lines_hash["Param_value:"] = param_value
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
    if params != nil
      params.split("=")[1]
    end
  end
end
