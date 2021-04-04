class TicketsController < ApplicationController
    def new
        @ticket = Ticket.new
        @movies = Movie.all
    end

    def create
        ticket = Ticket.new(ticket_params)
        ticket.user_id = session[:user_id]
        ticket.name = Movie.find_by(id: ticket.movie_id).name
        ticket.save
        redirect_to movies_path

        
    end



    private

    def ticket_params
        params.require(:ticket).permit(:movie_id, :quantity)
    end
end