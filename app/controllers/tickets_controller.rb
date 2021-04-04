class TicketsController < ApplicationController
    def new
     
        if params[:movie_id]
            @movie = Movie.find_by(id: params[:movie_id])
            @ticket = @movie.tickets.build
            @movies = Movie.all
        else
            @ticket = Ticket.new
            @movies = Movie.all
        end
    end

    def create
        movie = Movie.find_by(id: params[:ticket][:movie_id])
        ticket = Ticket.new(ticket_params)
        ticket.user_id = session[:user_id]
        ticket.name = movie.name
        ticket.save
        redirect_to movie_ticket_path(movie.id, ticket.id)
    end

    def show
        @movie = Movie.find_by(id: params[:movie_id])
        @ticket = Ticket.find_by(id: params[:id])
    end



    private

    def ticket_params
        params.require(:ticket).permit(:movie_id, :quantity)
    end
end