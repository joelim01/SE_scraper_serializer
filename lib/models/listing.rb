class Listing
  attr_accessor :address, :price, :url, :listing_type, :beds, :baths, :sqft

  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

end
