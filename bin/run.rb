#!/usr/bin/env ruby

require_relative "../config/environment.rb"

def run
  number_of_listings = 20
  neighborhood = 'soho'
  results_per_page = 12
  puts "Getting the #{number_of_listings} most expensive rental and sales listings in #{neighborhood}."
  puts "Edit the top-listings.rb file to change these parameters."
  puts Scraper.new.scrape('for-sale', number_of_listings, neighborhood, results_per_page)
  puts Scraper.new.scrape('for-rent', number_of_listings, neighborhood, results_per_page)
end

run()

# https://streeteasy.com/for-sale/soho?sort_by=price_desc
