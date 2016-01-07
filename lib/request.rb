require 'request_hash'
class Request
  attr_reader :request_lines_hash, :client

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
    request_lines
  end
end
