#!/usr/bin/env ruby
require 'rubygems'
require 'nfc'
require 'eventmachine'
require 'em-websocket'
require 'evma_httpserver'

@@tag = nil

class NfcHttpServer  < EventMachine::Connection
  include EventMachine::HttpServer
  
  def process_http_request
    res = EventMachine::DelegatedHttpResponse.new(self)
    puts "* http #{@http_request_method} #{@http_path_info} #{@http_query_string} #{@http_post_content}"
    res.status = 200
    res.content = @@tag
    res.send_response
  end
end


EM::run do
  channel = EM::Channel.new

  EM::start_server('0.0.0.0', 8081, NfcHttpServer)
  EM::WebSocket.start(:host => '0.0.0.0', :port => 8080) do |ws|
    ws.onopen do
      sid = channel.subscribe do |mes|
        ws.send mes
      end
      puts "* new client <#{sid}> connected"
      ws.send @@tag
      ws.onmessage do |mes|
        puts "* client <#{sid}> says : #{mes}"
      end

      ws.onclose do
        channel.unsubscribe sid
        puts "* client <#{sid}> closed"
      end
    end
  end

  EM::defer do
    nfc = NFC.instance
    puts "reader : #{nfc.device.name}"
    loop do
      tag = nfc.find.to_s.downcase
      if tag != @@tag
        puts "tag : #{tag}"
        channel.push tag.to_s
        @@tag = tag
      end
      sleep 0.1
    end
  end
end
