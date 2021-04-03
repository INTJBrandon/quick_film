class Movie < ApplicationRecord
    has_many :tickets
    has_many :users, through: :tickets
    validates_presence_of :name
    
end
