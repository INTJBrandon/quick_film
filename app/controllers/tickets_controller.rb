class TicketsController < ApplicationController

    before_action(:redirect_if_not_logged_in)

    def index 
        @user = User.find_by(id: params[:user_id])
    end

    def new
        if params[:movie_id]
            @collection = false
            set_movie_id
            @ticket = @movie.tickets.build
            @movies = Movie.all
        else
            @collection = true
            @ticket = Ticket.new
            @movies = Movie.all
        end
    end

    def create
        @movie = Movie.find_by(id: params[:ticket][:movie_id])
        @ticket = Ticket.new(ticket_params)
        movie_id = find_movie_id(@ticket.movie_id)
        if movie_id.blank?
            @ticket.user_id = session[:user_id]
            @ticket.name = @movie.name
            if @ticket.save
                flash[:message] = "Tickets Purchased!"
                session[:ticket_quantity] = @ticket.quantity
                redirect_to movie_ticket_path(@movie.id, @ticket.id)
            else
                render 'new'
            end
        else
            @ticket.user_id = session[:user_id]
            if @ticket.valid?
                new_quantity = movie_id[0].quantity += @ticket.quantity
                movie_id[0].update(movie_id: movie_id[0].movie_id, quantity: new_quantity)
                flash[:message] = "Tickets Purchased!"
                session[:ticket_quantity] = @ticket.quantity
                redirect_to movie_ticket_path(movie_id[0].movie_id, @ticket.movie_id)
            else
                render 'new'
            end
        end
    end

    def show
        set_movie_id
        @quantity = session[:ticket_quantity]
        session[:ticket_quantity] = nil
        @ticket = Ticket.find_by(id: params[:id])
    end



    private

    def ticket_params
        params.require(:ticket).permit(:movie_id, :quantity)
    end
end