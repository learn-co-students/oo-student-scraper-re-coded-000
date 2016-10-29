require 'nokogiri'
require 'open-uri'
require 'pry'


  def scrape_index_page(index_url)
    scraped_students=[]
    html = File.read('fixtures/student-site/index.html')#html = open(index_url)
     scrapped = Nokogiri::HTML(html)
      array=scrapped.css("div.roster-cards-container")
      array.each do |student_card|
        student_card.css(".student-card a").each do |e|
          student={}
          name=e.css(".student-name").text
          location=e.css(".student-location").text
          profile_url =e.attribute("href").value
          student[:name]=name
          student[:location]=location
          student[:profile_url ]="http://127.0.0.1:4000/"+profile_url
          scraped_students.push(student)

      end

      end
  return scraped_students

  end

  def scrape_profile_page(profile_url)
    profile={}
    html = File.read(profile_url)#html = open(index_url)
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
       return profile
  end

description-holder
#div.student-card
#.arr(id) .val
puts scrape_index_page("./fixtures/student-site/index.html").inspect
