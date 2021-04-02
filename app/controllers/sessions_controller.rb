class SessionsController < ApplicationController

    def new
    end

    def create
        @user = User.find_by(username: params[:user][:username])

        if @user && @user.authenticate(params[:users][:password])
            session[:user_id] = @user.id
            # redirect to home page or user profile (TODO)
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
        # redirect to signup or home page (TODO)
    end
end