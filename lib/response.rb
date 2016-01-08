require 'path_finder'

class Response
  attr_reader :param, :request_code
  def initialize(request_object, port, total_requests, hello_world_count)
    body = PathFinder.new(request_object, total_requests, hello_world_count).pathfinder
    response(request_object, port, body)
    @request_code = "200 ok"
    puts "\e[35mBODY:\e[32m#{body.inspect}"
  end

  def response(request_object, port, body)
    request_format = DiagnosticsFormatter.new(request_object.request_lines_hash, port).diagnostics
    diagnostics = request_format.join("\n")
    body_with_diagnostics = body + diagnostics

    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{body_with_diagnostics.length}\r\n\r\n"].join("\r\n"),
              "#{body_with_diagnostics}"
    request_object.client.puts headers
  end
end
