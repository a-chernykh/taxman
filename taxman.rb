#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"
require "date"
require_relative "lib/taxman"

FLAG_FILE = 'warning_shown.flag'

if Date.today.month == 7 && Date.today.day == 1 && 
	(!File.exists?(FLAG_FILE) || File.mtime(FLAG_FILE).to_date < Date.today)
	puts
	puts "*** Attention, it's July 1st, the tax rates might have changed\a"
	puts "*** Please check in with the site http://www.ato.gov.au/"
	puts "*** This message is shown only once"
	puts

	FileUtils.touch(FLAG_FILE)
end

ARGF.each do |line|
	puts Taxman.process(line.strip)
end
