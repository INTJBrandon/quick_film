class Ticket < ApplicationRecord
    belongs_to :users
    belongs_to :movies
    validates_presence_of :quantity
end
