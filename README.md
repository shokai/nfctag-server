NFC Tag Server
==============
read NFC Tag via HTTP, WebSocket and TCP Socket


Dependencies
============
* NFC Tag Reader - I'm using [IO-DATA USB2-NFC](http://www.amazon.co.jp/exec/obidos/ASIN/B001992ZS6/shokai-22)
* Ruby 1.8.7+
* NFC Tags


Install libnfc
--------------

for Mac OSX

    % brew install libnfc

Install Rubygems
------------

    % gem install bundler
    % bundle install


Run
===

Connect NFC Tag Reader, then

    % ./ntc-tag-server --help
    % ./nfc-tag-server
    % ./nfc-tag-server --http_port 8080 --websocket_port 8081 --socket_port 8082


Use
===

HTTP
----

    % curl 'http://localhost:8080'


WebSocket
---------

    ## JavaScript
    var ws = new WebSocket("ws://localhost:8081");
    ws.onmessage = function(e){
      Console.log(e.data);
    };


Socket
------

    % telnet localhost 8082


LICENSE:
========

(The MIT License)

Copyright (c) 2011 Sho Hashimoto

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.