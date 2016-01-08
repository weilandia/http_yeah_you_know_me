require 'request_hash'
class Request
  attr_reader :request_lines, :request_lines_hash, :client

  def initialize(client)
    @client = client
    @request_lines = request(client)
    @request_lines_hash = RequestHash.new(@request_lines).hash
  end

  def request(client)
    request_lines = []

    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end

    content_length_header = request_lines.find do |lines|
      lines.start_with?("Content-Length")
    end

    if content_length_header != nil
      length = content_length_header.split(" ")[1].to_i
      if length != 0
        body = client.read(length)
        request_lines << body
      end
    end
    request_lines
  end
end
