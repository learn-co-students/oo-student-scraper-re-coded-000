require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
     scraped_students=[]
     html = open(index_url)
      scrapped_page = Nokogiri::HTML(html)
      binding.pry
    end

end
