class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    if student_hash.key?(:name) ; @name=student_hash[:name] end
    if student_hash.key?(:location) ; @location=student_hash[:location] end
    if student_hash.key?(:twitter) ; @twitter=student_hash[:twitter] end
    if student_hash.key?(:linkedin) ; @linkedin=student_hash[:linkedin] end
    if student_hash.key?(:github) ; @github=student_hash[:github] end
    if student_hash.key?(:blog) ; @blog=student_hash[:blog] end
    if student_hash.key?(:profile_quote) ; @profile_quote=student_hash[:profile_quote] end
    if student_hash.key?(:bio) ; @bio=student_hash[:bio] end
    if student_hash.key?(:profile_url) ; @profile_url=student_hash[:profile_url] end
    @@all.push(self)
  end

  def self.create_from_collection(students_array)
    students_array.each do |e|
      Student.new(e)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k,v|
     self.send("#{k}=", v)
   end
  end

  def self.all
   return @@all
  end
end
