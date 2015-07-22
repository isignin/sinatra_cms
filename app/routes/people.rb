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
      
      get "/people/new" do
        @person = Person.new
        erb :"people/new"
      end
      
      get "/people/:id" do
        @person = Person[params[:id]]
        erb :"people/show"
      end

      post '/people' do
        @person = Person.create(params[:person])
        @person.lab = Lab.new
        if @person.save
          flash[:notice] = "Record created"
          erb :"/people"
        else
         flash[:notice] = "Error creating Record"
         erb :""
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