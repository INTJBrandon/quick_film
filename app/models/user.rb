class User < ApplicationRecord
    has_many :tickets
    has_many :movies, through: :tickets
    validates_uniqueness_of :username, :case_sensitive => false 
    validates_presence_of :username
    has_secure_password
end
