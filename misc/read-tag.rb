#!/usr/bin/env ruby
require 'rubygems'
require 'nfc'

nfc = NFC.instance
puts "reader : #{nfc.device.name}"

loop do
  begin
    tag = nfc.find
    unless tag
      puts "no tag"
    else
      puts tag.to_s
      puts "uid : #{tag.uid}"
    end
  rescue => e
    STDERR.puts e
  end
  sleep 1
end
