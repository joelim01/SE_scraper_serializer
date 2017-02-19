#!/usr/bin/env ruby
require_relative './utils/install_gems.rb'

install_gems do
  require 'nokogiri'
  require 'oj'
end

require_relative './modules/listing_validator.rb'
require_relative './modules/listing_serializer.rb'
require_relative './models/listing.rb'
require_relative './modules/scraper.rb'

def run
  number_of_listings = 20
  neighborhood = 'soho'
  results_per_page = 12
  puts "Getting the #{number_of_listings} most expensive rental and sales listings in #{neighborhood}."
  puts "Edit the top-listings.rb file to change these parameters."
  Scraper.new.scrape('for-sale', number_of_listings, neighborhood, results_per_page)
  Scraper.new.scrape('for-rent', number_of_listings, neighborhood, results_per_page)
end

run()

# https://streeteasy.com/for-sale/soho?sort_by=price_desc
