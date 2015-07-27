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
      
      get "/people/:id/edit" do
        @person = Person[params[:id]]
        erb :"people/edit"
      end

      post '/people' do
        @person = Person.create(params[:person])
        @person.lab = Lab.new
        if @person.save
          flash.now[:notice] = "Record created"
          erb :"/people/index"
        else
         flash.now[:alert] = "Error creating Record"
         erb :"/people/new"
        end
      end
        
      post '/person/:id' do
         @person = Person[params[:id]]
         if !@person.nil? && @person.update(params[:person])
           flash.now[:notice] = "Record updated successfully"
           erb :"people/show"
         else
           flash.now[:alert] = "Error updating record"
           erb :"people/edit"
         end 
      end
      
        
      delete '/person/:id' do
        person = Person[params[:id]]
        if !person.nil? 
          if person.delete
            flash.now[:notice] = "Record delete successfully"
          else
            status 500
            json person.errors.full_message
          end
        else
          flash.now[:alert] = "Record Not found"
        end  
      end 
      
      get '/people/contacts/:id' do
        @person = Person[params[:id]]
        @contacts = @person.contacts
        erb :"people/contacts"
      end
        
    end
  end
end      