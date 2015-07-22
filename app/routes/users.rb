module Cms
  module Routes
    class Users < Base
      configure do
        enable :partial_underscores
        set :partial_template_engine, :erb
      end
          
      get '/users' do
        @users = User.all
        erb :"users/index"
      end
      
      get "/users/:id" do
        @user = User[params[:id]]
        erb :"users/show"
      end
      
      post '/users' do
        user = User.new params[:user]
        if user.save
         "Record posted"
        else
         "Error saving record"
        end
      end
        
      put '/users/:id' do
         @user = User[params[:id]]
         if !@user.nil? && @user.update(params[:user])
           "Record updated successfully"
         else
           "Error updating record"
         end 
      end
      
        
      delete '/user/:id' do
        user = User[params[:id]]
        if !user.nil? 
          if user.delete
            "Record delete successfully"
          else
            status 500
            json user.errors.full_message
          end
        else
          "Record Not found"
        end  
      end  
      
      get '/login' do
        erb :"users/login"
      end  
      
      post '/login' do

        @user = User[:username => params[:username]]
         if !@user.nil?
           if @user.password != params[:password] 
            flash[:notice] = "Incorrect password" 
             redirect '/login'    
            else 
              if !@user.verified
               flash[:notice] = "User is not verified"
               redirect '/login'
              else
                flash[:notice] = "User is verified. You are ok, #{@user.username}"
              end 
            end  
         else
          flash[:notice] = "I don't know you #{params[:username]}"
          redirect '/login'
         end
      end
      
      post '/sign_up' do
        require 'securerandom'
        
        @user = User.new params[:user]
        @user.verified = false
        @user.token = SecureRandom.urlsafe_base64.gsub(/\W+/, '')
        if @user.save
          #Send email
          Pony.mail :to => @user.email,
                    :from => 'admin@example.com',
                    :subject => 'Email address verification',
                    :body => erb(:"users/verification_mail")
          "Verification Email sent"
        else
          "Error saving record"
          user.errors.full_message
        end    
      end
      
      get '/verify/:token' do
        @user = User[:token => params[:token]]
        if !@user.nil?
          if @user.update(:token => nil, :verified => true)
            erb :"users/verified"
          else
             @user.errors.full_message
          end
        else
          "Token invalid. Please contact your administrator"
        end
      end
      
      post '/reset_password' do
        @user = User[:username => params[:username]]
        if !@user.nil?
          @user.update(:token => SecureRandom.urlsafe_base64.gsub(/\W+/, ''))
          #Send reset email
          Pony.mail :to => @user.email,
                    :from => 'admin@example.com',
                    :subject => 'Password reset',
                    :body => erb(:"users/password_reset_mail")
          "Password reset email sent"
        else
          "I do not know you...."
        end    
      end
      
      get '/reset_password/:long_token' do
        @user = User[:token => params[:token]]
        if !@user.nil?
          @user.update(:token => nil)
          erb :"users/password_reset_form"
        else
          "Token invalid. Please contact your administrator"
        end
      end
      
      post 'reset_now' do
        if params[:password] == params[:pass_confirm]
         @user = User[params[:id]]
         if @user.nil?
           "Do not know you..."
         else
           if @user.update(:password => params[:password])
             "Password has been reset"
           else
             "Error encountered resetting your password. Please contact your administrator"
           end      
         end
        else
          "New Password does not match your confirm password"
        end 
      end
          
    end
  end
end