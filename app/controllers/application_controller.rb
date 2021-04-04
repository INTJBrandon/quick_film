class ApplicationController < ActionController::Base

    helper_method(:logged_in?, :current_user)
    def current_user
        @current_user = User.find_by(id: session[:user_id])
        @current_user.username
      end

      def require_login
        ((flash[:message] = "You must be logged in to do that") && (redirect_to '/login')) if !current_user
      end

    def set_movie
       @movie =  Movie.find_by(id: params[:ticket][:movie_id])
    end

    def logged_in?
        if session[:user_id]
            return true
        else
            return false
        end
    end
end
