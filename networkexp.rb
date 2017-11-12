#!/usr/bin/env ruby
require 'net/http'
puts "start"
h = Net::HTTP.new('https://pragprog.com/', 80)
resp, data = h.get('/index.html', nil)
if resp.message == "OK"
  data.scan(/<img src="(.*?)"/) { |x| puts x }
end
