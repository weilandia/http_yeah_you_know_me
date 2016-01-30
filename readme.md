#HTTP Yeah You Know Me

###Description:
This project is a learning exercise to explore HTTP. We built functioning web server in Ruby to explore HTTP requests and added a simple guessing game for some fun.

###Testing
To run our test suite, start our main server and test server by running 'start_server.rb' and 'test_server.rb' in separate terminals. Then, run 'mrspec' to run all test files, or run each individual test file with Minitest.

###Background:
The internet, which for most people is the web...how does that work?

HTTP (HyperText Transfer Protocol) is the protocol used for sending data from your browser to a web server then getting data back from the server. As protocols go, it's actually a very simple one.

###Understanding HTTP Metaphor
Imagine that you're requesting information from a penpal (old school with paper, envelopes, etc). The protocol would go something like this:

* You write a letter requesting information
* You wrap that letter in an envelope
* You add an address that uniquely identifies the destination of the letter
* You hand the sealed enveloper to your mail person
* It travels through a network of people, machines, trucks, planes, etc
* Assuming the address is correct, it arrives at your penpal's mailbox
* Your penpal opens the envelope and reads the letter
* Assuming they understand your question, your penpal writes a letter of their own back to you
* They wrap it in an envelope and add an address that uniquely identifies you (which they got from the return address on *your* envelope)
* They hand their letter to their mail person, it travels through a series of machines and people, and eventually arrives back at your mailbox
* You open the envelope and do what you see fit with the information contained in there.

###HTTP For Real
Metaphor aside, let's run through the protocol as executed by computers:

* You open your browser and type in a web address like `http://turing.io` and hit enter. The URL (or "address") that you entered is the core of the letter.
* The browser takes this address and builds a *request*, the envelope. It uniquely identifies the machine (or *server*) out there on the internet that the message is intended for. It includes a return address and other information about the requestor.
* The request is handed off to your Internet Service Provider (ISP) (like CenturyLink or Comcast) and they send it through a series of wires and fiber optic cables towards the server
* The request arrives at the server. The server reads the precisely formatted request to figure out (a) who made the request and (b) what they requested
* The server fetches or calculates the requested information and prepares a *response*. The response wraps the requested information in an envelope that has the destination address on it (your machine).
* The server hands the response off to their ISP and it goes through the internet to arrive at your computer
* Your browser receives that response, unwraps it, and displays the data on your machine.

That's HTTP. You can read more on [wikipedia article](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol)
or the [IETF specification](https://tools.ietf.org/html/rfc2616).

###HTTP Requests
Here is what an actual request looks like. Note that it's just a single highly-formatted string:

```
GET / HTTP/1.1
Host: 127.0.0.1:9292
Connection: keep-alive
Cache-Control: max-age=0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36
Accept-Encoding: gzip, deflate, sdch
Accept-Language: en-US,en;q=0.8
```

###HTTP Responses
The Server generates and transmits a response that looks like this:

```
http/1.1 200 ok
date: Sun,  1 Nov 2015 17:25:48 -0700
server: ruby
content-type: text/html; charset=iso-8859-1
content-length: 27

The response body goes here
```
