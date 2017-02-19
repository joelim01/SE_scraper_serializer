class Scraper
    attr_reader :listings

  # this script currently employs local data
  # to use live data, replace local_pages call with get_pages in get_listing_data

  def initialize()
    @listings = []
  end

  def scrape(type_of_listing, number_of_listings, neighborhood, results_per_page)
    @type_of_listing = type_of_listing
    @number_of_listings = number_of_listings
    @neighborhood = neighborhood
    @results_per_page = results_per_page
    save_listings()
  end

  private

  def get_page(url)
    doc = Nokogiri::HTML(open(url))
  end

  def local_pages
    file = File.read("../data/#{@type_of_listing}.html")
    file2 = File.read("../data/#{@type_of_listing}2.html")
    pages = []
    pages << Nokogiri::HTML(file)
    pages << Nokogiri::HTML(file2)
    pages
  end

  def get_pages
    pages = []
    url = "https://streeteasy.com/#{@type_of_listing}/#{@neighborhood}?sort_by=price_desc"
    pages << get_page(url)
    if (@number_of_listings > @results_per_page)
      number_of_pages = (@number_of_listings/@results_per_page.to_f).ceil
      for i in (2..number_of_pages)
        url = "https://streeteasy.com/#{@type_of_listing}/#{@neighborhood}?page=#{i}&sort_by=price_desc"
        pages << get_page(url)
      end
    end
    pages
  end

  # this script currently employs local data
  # to use live data, replace local_pages call with get_pages
  
  def get_listing_data
    listing_data = []
    # get_pages.each do |page|
    local_pages.each do |page|
      listing_data << page.css('div[@class = "item"]')
    end
    listing_data
  end

  def create_listings
    listing_data = get_listing_data
    if listing_data.respond_to?(:each)
      listing_data.each do |ld|
        parse_listings(ld)
      end
    else
      parse_listings(ld)
    end
    @listings.first(@number_of_listings)
  end

  def parse_listings(listings)
    listings.each do |l|
      listing = Listing.new
      ListingValidator.validate(l, listing)
      @listings << listing
    end
  end

  def serialize_listings
    json_array = create_listings.map do |l|
      l.serialize.strip
    end
    json_array
  end

  def save_listings
    File.open("#{@type_of_listing}.json", "w+") do |f|
      f.print('[')
      serialize_listings.each_with_index do |l, i|
        if (i == @number_of_listings-1)
          f.puts(l + ']')
        else
          f.puts(l + ',')
        end
      end
    end
  end

end
