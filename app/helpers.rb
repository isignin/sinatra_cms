module Cms
  module Helpers
    def fullname(person)
      person.first_name+" "+person.last_name
    end 
    #require 'app/helpers/people_helper'
  end
end