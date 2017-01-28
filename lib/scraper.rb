require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html=open(index_url)
    doc=Nokogiri::HTML(html)
    students=[]
    doc.css("div.roster-cards-container").each do |s|
      s.css(".student-card a").each do |student|
        student_profile_link = "http://46.101.236.30:30018/#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << {name: student_name, location: student_location, profile_url: student_profile_link}

    end
  end
  students
end
  def self.scrape_profile_page(profile_url)
    student = {}
       profile_page = Nokogiri::HTML(open(profile_url))
       links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
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
