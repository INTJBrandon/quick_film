class TicketsController < ApplicationController

    before_action(:redirect_if_not_logged_in)

    def new
        if params[:movie_id]
            set_movie_id
            @ticket = @movie.tickets.build
            @movies = Movie.all
        else
            @ticket = Ticket.new
            @movies = Movie.all
        end
    end

    def create
        movie = Movie.find_by(id: params[:ticket][:movie_id])
        @ticket = Ticket.new(ticket_params)
        movie_id = find_movie_id(@ticket.movie_id)
        if movie_id.blank?
            @ticket.user_id = session[:user_id]
            @ticket.name = movie.name
            if @ticket.save
                flash[:message] = "Tickets Purchased!"
                redirect_to movie_ticket_path(movie.id, @ticket.id)
            else
                flash[:messages] = "Something went wrong, please try again later"
                redirect_to movies_path
            end
        else
            new_quantity = movie_id[0].quantity += @ticket.quantity
            movie_id[0].update(movie_id: movie_id[0].movie_id, quantity: new_quantity)
            flash[:message] = "Tickets Purchased!"
            redirect_to movie_ticket_path(movie_id[0].movie_id, movie_id[0].id )
        end
    end

    def show
        set_movie_id
        @ticket = Ticket.find_by(id: params[:id])
    end



    private

    def ticket_params
        params.require(:ticket).permit(:movie_id, :quantity)
    end
end