class ApplicationController < ActionController::Base

    helper_method(:logged_in?, :current_username)
    def current_username
        @current_user = User.find_by(id: session[:user_id])
        @current_user.username
      end

    def current_user
        @current_user = User.find_by(id: session[:user_id])
    end

    def redirect_if_not_logged_in
        if !logged_in?
            redirect_to login_path
        end
    end

    def set_movie_id
       @movie =  Movie.find_by(id: params[:movie_id])
    end

    def set_movie
        @movie =  Movie.find_by(id: params[:id])
    end

    def logged_in?
        if session[:user_id]
            return true
        else
            return false
        end
    end
end
