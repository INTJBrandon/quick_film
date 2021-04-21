class SessionsController < ApplicationController

    def new
        @errors = []
    end

    def create
        @user = User.find_by(username: params[:user][:username])


        if @user && @user.authenticate(params[:user][:password])
            
            session[:user_id] = @user.id
            flash[:messages] = "Successfully Logged in"
            redirect_to movies_path
        elsif @user
            @errors = ["Invalid Password"]
            render "new"
        else
            @errors = ["Invalid Username"]
            render "new"
        end
    end

    def google_login
        user = User.find_or_create_by(username: g_auth['email']) do |u|
            u.password = SecureRandom.hex(5)
        end
        if user.save
            flash[:message] = "Login Successful!"
            session[:user_id] = user.id
            redirect_to movies_path
        else
            flash[:message] = "Login Failed via google"
            redirect_to signup_path
        end
    end


    def destroy
        session.clear
        redirect_to movies_path
    end


    private 
    
    def g_auth
        self.request.env['omniauth.auth']['info']
    end
end