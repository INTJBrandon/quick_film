class User < ApplicationRecord
    has_many :bought_tickets
    has_many :tickets, through: :bought_tickets
    validates_uniqueness_of :username
    validates_presence_of :username
    has_secure_password

end
