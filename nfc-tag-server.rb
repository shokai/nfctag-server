#!/usr/bin/env ruby
require 'rubygems'
require 'nfc'
require 'eventmachine'
require 'em-websocket'

EM::run do
  channel = EM::Channel.new
  EM::WebSocket.start(:host => '0.0.0.0', :port => 8080) do |ws|
    ws.onopen do
      sid = channel.subscribe do |mes|
        ws.send mes
      end
      puts "* new client <#{sid}> connected"

      ws.onmessage do |mes|
        puts "* client <#{sid}> says : #{mes}"
      end

      ws.onclose do
        @channel.unsubscribe sid
        puts "* client <#{sid}> closed"
      end
    end
  end

  EM::defer do
    nfc = NFC.instance
    puts "reader : #{nfc.device.name}"
    tag_p = nil
    loop do
      tag = nfc.find.to_s
      if tag != tag_p
        puts "tag : #{tag}"
        channel.push tag.to_s
        tag_p = tag
      end
      sleep 0.1
    end
  end
end
