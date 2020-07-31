class User < ApplicationRecord
    has_many :stays
    has_many :hosts, foreign_key:'host_id', class_name: "CreateTrips"
    has_many :customers, foreign_key:'customer_id', class_name: "CreateTrips"
    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+.)+[^@\s]+\z/, message: "email adress please" }
    validates :phone_number, format: { with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/, message: 'please enter a valid french number' }
end
