require_relative '../lib/utils/install_gems.rb'

install_gems do
  require 'nokogiri'
  require 'oj'
end

require_relative '../lib/modules/listing_validator.rb'
require_relative '../lib/modules/listing_serializer.rb'
require_relative '../lib/models/listing.rb'
require_relative '../lib/modules/scraper.rb'
