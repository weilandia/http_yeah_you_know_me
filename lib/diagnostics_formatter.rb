require 'request'

class DiagnosticsFormatter
  attr_reader :diagnostics

  def initialize(request_lines_hash, port)
    @port = port
    @diagnostics = diagnostic_format(request_lines_hash, port)
  end

  def diagnostic_format(request_lines_hash, port)
    diagnostic_format = ["Verb: #{request_lines_hash["Verb:"]}",
        "Path: #{request_lines_hash["Path:"]}",
        "Protocol: #{request_lines_hash["Protocol:"]}",
        "Host: #{request_lines_hash["Host:"].split(":")[0]}",
        "Port: #{port}",
        "Origin: #{request_lines_hash["Host:"].split(":")[0]}",
        "Accept: #{request_lines_hash["Accept:"]}"]
      diagnostic_format
  end
end
