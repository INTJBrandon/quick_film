class Movie < ApplicationRecord
    has_many :bought_tickets
    has_many :users, through: :bought_tickets
end
