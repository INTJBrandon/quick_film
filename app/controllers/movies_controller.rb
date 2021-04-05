class MoviesController < ApplicationController
    def index
        @movies = Movie.all
    end

    def topRated
        @movies = Movie.all.top_rated
        render "index"
    end

    def show
        @movie = Movie.find_by(id: params[:id])
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
        @movie = Movie.find_by(id: params[:id])
    end

    def update
        movie = Movie.find_by(id: params[:id])
        movie.update(movie_params)
        redirect_to movie_path(movie)
    end

    def destroy
        movie = Movie.find_by(id: params[:id])
        movie.delete
        redirect_to movies_path
    end




    private 

    def movie_params
        params.require(:movie).permit(:name, :rated)
    end
end