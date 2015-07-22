module PeopleHelper
  def fullname(person)
    person.first_name+" "+person.last_name
  end  
end