class ListingValidator
  require 'uri'

  def self.validateListing(data, listing)
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
      listing.price = data.css('div.price-info span.price').text
    else
      listing.price = "Price unavailable."
    end
    #details
    if data.css('div.details_info span.detail_cell').text != ""
      listing.beds = data.css('div.details_info span.first_detail_cell').text
      listing.baths = data.css('div.details_info span.detail_cell').text
      listing.sqft = data.css('div.details_info span.last_detail_cell').text
    else
      if data.css('div.details_info span.first_detail_cell').text =~ /bed/i
        listing.beds = data.css('div.details_info span.first_detail_cell').text
      elsif data.css('div.details_info span.first_detail_cell').text =~ /bath/i
        listing.baths = data.css('div.details_info span.first_detail_cell').text
      elsif data.css('div.details_info span.first_detail_cell').text =~ /sqft/i
        listing.sqft = data.css('div.details_info span.first_detail_cell').text
      end
      if data.css('div.details_info span.detail_cell').text =~ /bed/i
        listing.beds = data.css('div.details_info span.detail_cell').text
      elsif data.css('div.details_info span.detail_cell').text =~ /bath/i
        listing.baths = data.css('div.details_info span.detail_cell').text
      elsif data.css('div.details_info span.detail_cell').text =~ /sqft/i
        listing.sqft = data.css('div.details_info span.detail_cell').text
      end
      if data.css('div.details_info span.last_detail_cell').text =~ /bed/i
        listing.beds = data.css('div.details_info span.last_detail_cell').text
      elsif data.css('div.details_info span.last_detail_cell').text =~ /bath/i
        listing.baths = data.css('div.details_info span.last_detail_cell').text
      elsif data.css('div.details_info span.last_detail_cell').text =~ /sqft/i
        listing.sqft = data.css('div.details_info span.last_detail_cell').text
      end
    end
  end
end
