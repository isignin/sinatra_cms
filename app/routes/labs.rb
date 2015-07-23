module Cms
  module Routes
    class Labs < Base
      configure do
        enable :partial_underscores
        set :partial_template_engine, :erb
      end
    
      get '/labs' do
        @labs = Lab.all
        erb :"labs/index"
      end
    
      get "/labs/:id" do
        @lab = Lab[params[:id]]
        erb :"labs/show"
      end
      
      get "/labs/:id/edit" do
        @lab = Lab[params[:id]]
        erb :"labs/edit"
      end
    
      post '/labs' do
        @lab = Lab.new params[:lab]
        if @lab.save
         flash.now[:notice]="Lab Record posted"
         erb :"labs/show"
        else
         flash.now[:notice] = "Error saving Lab Record"
         erb :"labs/edit"
        end
      end
      
      post '/lab/:id' do
         @lab = Lab[params[:id]]
         if !@lab.nil? && @lab.update(params[:lab])
           flash.now[:notice] ="Lab Record updated successfully"
           erb :"labs/show"
         else
           flash.now[:notice] = "Error updating Lab record"
           erb :"labs/edit"
         end 
      end
    
      
      delete '/labs/:id' do
        lab = Lab[params[:id]]
        if !lab.nil? 
          if lab.delete
            flash.now[:notice]= "Lab Record delete successfully"
          else
            status 500
            json person.errors.full_message
          end
        else
         flash.now[:notice] = "Lab Record Not found"
        end  
      end 
    end 
  end
end      