class Stay < ApplicationRecord
    has_many :trips
    belongs_to :user, optional: true
    belongs_to :city, optional: true
end
