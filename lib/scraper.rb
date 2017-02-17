class Scraper

  def initialize(number_of_listings, neighborhood, results_per_page)
    @number_of_listings = number_of_listings
    @neighborhood = neighborhood
    @results_per_page = results_per_page
    @file = File.read('../data/source.html')
  end

  def get_page(url)
    Nokogiri::HTML(@file)
    # doc = Nokogiri::HTML(open(url))
  end

  def get_pages
    @pages = []
    @url = "https://streeteasy.com/for-sale/#{@neighborhood}?sort_by=price_desc"
    @pages << get_page(url)
    if (@number_of_listings > @results_per_page)
      number_of_pages = (20/12.to_f).ceil
      for i in (2..number_of_pages)
        @url = "https://streeteasy.com/for-sale/#{@neighborhood}?page=#{i}&sort_by=price_desc"
        @pages << get_page(url)
      end
    end
    @pages
  end

  def get_listings
    self.get_pages.css('div[@class = "item"]')
  end

  def create_listings
    self.get_listings.each do |listing|
      # link
      listing.css('div.details-title > a').attribute("href").value
      # address
      listing.css('div.details-title > a').text
      # price
      listing.css('div.price-info span.price').text
      # beds
      listing.css('div.details_info span.first_detail_cell').text
      # baths
      listing.css('div.details_info span.second_detail_cell').text
      # sqft
      listing.css('div.details_info span.third_detail_cell').text
    end
  end

  def serialize_listings
  end

  def save_listings
  end


end
