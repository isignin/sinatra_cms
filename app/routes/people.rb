module Cms
  module Routes
    class People < Base
      configure do
        enable :partial_underscores
        set :partial_template_engine, :erb
      end
          
      get '/people' do
        @people = Person.all
        erb :"people/index"
      end
      
      get "/people/:id" do
        @person = Person[params[:id]]
        erb :"people/show"
      end
      
      post '/people' do
        person = Person.new params[:person]
        if person.save
         "Record posted"
        else
         "Error saving record"
        end
      end
        
      put '/people/:id' do
         @person = Person[params[:id]]
         if !@person.nil? && @person.update(params[:person])
           "Record updated successfully"
         else
           "Error updating record"
         end 
      end
      
        
      delete '/person/:id' do
        person = Person[params[:id]]
        if !person.nil? 
          if person.delete
            "Record delete successfully"
          else
            status 500
            json person.errors.full_message
          end
        else
          "Record Not found"
        end  
      end 
      
      get '/people/contacts/:id' do
        @person = Person[params[:id]]
        @contacts = @person.contacts_with + @person.contacts_by
        erb :"people/contacts"
      end
        
    end
  end
end      