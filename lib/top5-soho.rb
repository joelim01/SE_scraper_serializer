#!/usr/bin/env ruby
require_relative './listing.rb'
require_relative './install_gems.rb'
require_relative './scraper.rb'

install_gems do
  require 'nokogiri'
  require 'open-uri'
end
