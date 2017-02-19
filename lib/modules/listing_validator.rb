class ListingValidator
  require 'uri'

  def self.validate(data, listing)
    # url
    if data.css('div.details-title > a').attribute("href").value =~ URI::regexp
      listing.url = data.css('div.details-title > a').attribute("href").value
    else
      listing.url = "Url unavailable."
    end
    # address
    if data.css('div.details-title > a').text != ""
      listing.address = data.css('div.details-title > a').text
    else
      listing.address = "Address unavailable."
    end
    # price
    if data.css('div.price-info span.price').text != ""
      listing.price = data.css('div.price-info span.price').text.gsub(/[^0-9\.]/i, "")
    else
      listing.price = "Price unavailable."
    end
    # details
    # parse all detail_cells and put the data in the right spot
    data.css('div.details_info span').each do |s|
      if s.text =~ /bed/i
        listing.beds = s.text.gsub(/[^0-9\.]/i, "")
      elsif s.text =~ /bath/i
        listing.baths = s.text.gsub(/[^0-9\.]/i, "")
      elsif s.text =~ /ft/i
        listing.sqft = s.text.gsub(/[^0-9\.]/i, "")
      end
    end
  end
end
