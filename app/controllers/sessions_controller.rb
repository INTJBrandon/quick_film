class SessionsController < ApplicationController

    def new
    end

    def create
        @user = User.find_by(username: params[:user][:username])


        if @user && @user.authenticate(params[:user][:password])
            
            session[:user_id] = @user.id
            # redirect to home page or user profile (TODO)
            redirect_to movies_path
        elsif @user
            @errors = ["Invalid Password"]
            render "new"
        else
            @errors = ["Invalid Username"]
            render "new"
        end
    end

    def destroy
        session.clear
        redirect_to movies_path
    end


end