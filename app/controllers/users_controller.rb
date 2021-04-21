class UsersController < ApplicationController
    before_action :redirect_if_not_logged_in, only: [:index]
    def new 
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to movies_path
        else
            @errors = @user.errors.full_messages
        end
    end

    def index
        @user = current_user
    end











    private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end