#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require './android_checkout_scraper'
require './secrets.rb'
require './config.rb'

if (ARGV.size < 2)
  STDERR.puts "Usage: #{$0} <start_date> <end_date> [<state>] [--details]"
  exit 1
end

startdate = ARGV[0]
enddate = ARGV[1]
details = false
if (ARGV.size >= 3 and ARGV[2] != '--details')
  state = ARGV[2]
else
  state = "CHARGED"
end

if (ARGV[ARGV.size - 1] == '--details')
  details = true
end

scraper = AndroidCheckoutScraper.new
if ($proxy_host != nil)
  scraper.proxy_host = $proxy_host
  scraper.proxy_port = $proxy_port
end

scraper.email = $email_address
scraper.password = $password

csv = scraper.getOrderList(startdate, enddate, state, details)
puts csv
#scraper.dumpCsv(csv)
