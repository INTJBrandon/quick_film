class MoviesController < ApplicationController
    def index
        @movies = Movie.all
    end

    def topRated
        @movies = Movie.top_rated
        render "index"
    end

    def show
        set_movie
    end

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            redirect_to movie_path(@movie)
        else
            render "new"
        end
    end

    def edit
        set_movie
    end

    def update
        set_movie
        @movie.update(movie_params)
        redirect_to movie_path(@movie)
    end

    def destroy
        set_movie
        @movie.delete
        redirect_to movies_path
    end




    private 

    def movie_params
        params.require(:movie).permit(:name, :rated)
    end
end