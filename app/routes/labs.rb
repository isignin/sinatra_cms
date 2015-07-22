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
    
      post '/labs' do
        lab = Lab.new params[:lab]
        if lab.save
         "Lab Record posted"
        else
         "Error saving Lab Record"
        end
      end
      
      put '/lab/:id' do
         @lab = Lab[params[:id]]
         if !@lab.nil? && @lab.update(params[:lab])
           "Lab Record updated successfully"
         else
           "Error updating Lab record"
         end 
      end
    
      
      delete '/lab/:id' do
        lab = Lab[params[:id]]
        if !lab.nil? 
          if lab.delete
            "Lab Record delete successfully"
          else
            status 500
            json person.errors.full_message
          end
        else
          "Lab Record Not found"
        end  
      end 
    end 
  end
end      