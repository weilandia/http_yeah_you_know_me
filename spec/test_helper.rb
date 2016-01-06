class MyClient
  def initialize(lines = "GET / HTTP/1.1
Host: 127.0.0.1:9292
Connection: keep-alive
Cache-Control: max-age=0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36
Accept-Encoding: gzip, deflate, sdch
Accept-Language: en-US,en;q=0.8

")
    @lines = lines.lines
  end

  def gets
    # if @lines.length <= 1
    #   raise "CALLED GETS WHEN THERE WAS ONE #{@lines.length} LINE LEFT!"
    # end
    @lines.shift
  end
end
