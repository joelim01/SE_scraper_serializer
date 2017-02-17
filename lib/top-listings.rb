#!/usr/bin/env ruby
require_relative './models/listing.rb'
require_relative './install_gems.rb'
require_relative './scraper.rb'

install_gems do
  require 'nokogiri'
  require 'open-uri'
  require 'pry'
end

binding.pry

def run
  number_of_listings = 20
  neighborhood = 'soho'
  results_per_page = 12
  puts "Getting listings."
  s = Scraper.new(20, 'soho')
  s.save_listings()
end

# https://streeteasy.com/for-sale/soho?sort_by=price_desc
