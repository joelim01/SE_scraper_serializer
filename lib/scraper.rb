class Scraper

  def initialize(url)

  end

  def get_page

  end

  def get_listings
  end

  def create_listings
  end

  def serialize_listings

  def save_listings
  end

  def interface
    puts "Getting the 5 most expensive listings in Soho, NYC."
    getData()
    puts ""
    parseData()
    promptForLocation()
    saveData()
  end
