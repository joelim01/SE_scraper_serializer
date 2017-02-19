# SE Scraper and Serializer

### Challenges
- A public API is not available for this data (the problem would become trivial if it were)
  - Verified with StreetEasy support that the API is no longer available
- The StreetEasy site is unscrapable
  - Verified with StreetEasy support that the site is meant to be unscrapable

### Assumptions
- The assignment states to 'make any assumptions needed.'
- The most important and largest assumption I made was that the exercise was about producing code that could be used to evaluate coding proficiency and not about producing useful software. **Typically that is not the case and I would ask for clarification rather than produce code.**

This script can scrape the most expensive rental and sales listings in a given neighborhood from the StreetEasy website and output a json file with the following structure:

```
[{
  "url":"http://streeteasy.com/building/20-greene-street-new_york/pha",
  "address":"20 Greene Street #PHA",
  "price":"75000",
  "beds":"3",
  "baths":"3.5",
  "sqft":"4300",
  "listing_type":"for-rent"
}]
```

## Dependencies
- Ruby 2.4.0
- This script relies on the 'Nokogiri' and 'Oj' gems to scrape and parse the HTML and serialize Ruby objects, respectively.

## Local vs External data
 - Currently, the script executes against locally stored HTML files
 - If the site allowed scraping, there are methods within the scraper class to scrape the site

## Editable variables in run.rb
- number_of_listings
- neighborhood
- results_per_page (should match StreetEasy's default number of listings per page)

## Output
- Files are written to the data/json folder

## Running the script
- Run the Ruby binary in bin with `ruby run.rb`
- If you are missing any gems the script prompt you to install them
