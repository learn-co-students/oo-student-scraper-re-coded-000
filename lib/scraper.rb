require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
   students = []
   doc.search("div.roster-body-wrapper>div.roster-cards-container").each do |card|
     card.search("div.student-card a").each do |student|
       student_link = "http://127.0.0.1:4000/#{student.attribute('href').value}"
       student_location = student.css('p.student-location').text
       student_name = student.css('h4.student-name').text
       students << {name: student_name, location: student_location, profile_url: student_link}
     end
   end
   students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
   profile_page = Nokogiri::HTML(open(profile_slug))
   links = profile_page.css("div.social-icon-container").children.css("a").map { |l| l.attribute('href').value}
   links.each do |link|
     if link.include?("linkedin")
       student[:linkedin] = link
     elsif link.include?("github")
       student[:github] = link
     elsif link.include?("twitter")
       student[:twitter] = link
     else
       student[:blog] = link
     end
   end
  student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
      student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

      student
    end
end
