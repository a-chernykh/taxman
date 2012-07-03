#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"
require_relative "lib/taxman"

ARGF.each do |line|
	puts Taxman.process(line.strip)
end