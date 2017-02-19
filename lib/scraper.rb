class Scraper

    attr_reader :listings

  def initialize(type_of_listing, number_of_listings, neighborhood, results_per_page)
    @type_of_listing = type_of_listing
    @number_of_listings = number_of_listings
    @neighborhood = neighborhood
    @results_per_page = results_per_page
    @file = File.read("../data/#{@type_of_listing}.html")
    @file2 = File.read("../data/#{@type_of_listing}2.html")
    @listings = []
  end

  def get_page(url)
    doc = Nokogiri::HTML(open(url))
  end

  def local_pages
    pages = []
    pages << Nokogiri::HTML(@file)
    pages << Nokogiri::HTML(@file2)
    pages
  end

  def get_pages
    pages = []
    url = "https://streeteasy.com/#{@type_of_listing}/#{@neighborhood}?sort_by=price_desc"
    pages << get_page(url)
    if (@number_of_listings > @results_per_page)
      number_of_pages = (20/12.to_f).ceil
      for i in (2..number_of_pages)
        url = "https://streeteasy.com/#{@type_of_listing}/#{@neighborhood}?page=#{i}&sort_by=price_desc"
        pages << get_page(url)
      end
    end
    pages
  end

  def get_listing_data
    listing_data = []
    self.local_pages.each do |page|
      listing_data << page.css('div[@class = "item"]')
    end
    listing_data
  end

  def create_listings
    self.get_listing_data.each do |ld|
      ld.each do |l|
        listing = Listing.new
        ListingValidator.validateListing(l, listing)
        @listings << listing
      end
    end
    @listings
  end

  def serialize_listings
    json_array = []
    json_array = self.create_listings.map do |l|
      ListingSerializer.serialize(l)
    end
    binding.pry
    json_array
  end

  def save_listings
    File.open("#{type_of_listing}.json", "w+") do |f|
      f.puts(serialize_listings)
    end
  end


end
