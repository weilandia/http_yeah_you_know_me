require 'request'

class RequestFormatter
  attr_reader :request_lines_hash

  def initialize(request)
    @request = request
  end

  def request_format
    request_lines_hash = @request.request_lines_hash

    request_format = ["Verb: #{request_lines_hash["Verb:"]}",
        "Path: #{request_lines_hash["Path:"]}",
        "Protocol: #{request_lines_hash["Protocol:"]}",
        "Host: #{request_lines_hash["Host:"].split(":")[0]}",
        "Port: #{@request.port}",
        "Origin: #{request_lines_hash["Host:"].split(":")[0]}",
        "Accept: #{request_lines_hash["Accept:"]}"]
      request_format
  end
end
