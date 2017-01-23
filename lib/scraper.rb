require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
     scraped_students=[]
     html = open("fixtures/student-site/index.html")
      scrapped = Nokogiri::HTML(html)
       array=scrapped.css("div.roster-cards-container")
       array.each do |student_card|

         student_card.css(".student-card a").each do |e|
           student={}
           name=e.css(".student-name").text
           location=e.css(".student-location").text
           profile_url =e.attribute("href").value
           student[:name] = name
           student[:location] = location
           student[:profile_url ] = "http://127.0.0.1:4000/#{profile_url}"
           scraped_students.push(student)
       end
       end
   return scraped_students
   end

   def self.scrape_profile_page(profile_url)
     profile={}
     arr=profile_url.split("4000/")
     profile_url=arr[1]
     html = open("#{profile_url}")
      scrapped = Nokogiri::HTML(html)
       array=scrapped.css("div.social-icon-container a")
        array.each do |e|
          if e.attribute("href").value.include?("twitter")
             profile[:twitter]=e.attribute("href").value
          elsif  e.attribute("href").value.include?("linkedin")
                        profile[:linkedin]=e.attribute("href").value
          elsif  e.attribute("href").value.include?("github")
                profile[:github]=e.attribute("href").value
          elsif  e.attribute("href").value.include?("facebook")
                    profile[:facebook]=e.attribute("href").value
           else
             profile[:blog]=e.attribute("href").value
           end
        end
        quote=scrapped.css(".profile-quote").text
        profile[:profile_quote]=quote
        bio=scrapped.css(".description-holder p").text
        profile[:bio]=bio

        return profile
   end
end
