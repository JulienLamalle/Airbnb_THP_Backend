class Trip < ApplicationRecord
    belongs_to :stay, optional: true
    belongs_to :host, class_name: "User"
    belongs_to :customer, class_name: "User"

    validates_presence_of :start_date, :end_date
    validate :end_date_is_after_start_date

    validate :overlaps?
    scope :overlapping, ->(period_start, period_end) do
        where "((star_date <= ?) and (end_date >= ?))", period_end, period_start
    end

    after_create :welcome
    after_create :duration

    def end_date_is_after_start_date
        return if end_date.blank? || start_date.blank?
        if end_date < start_date
            errors.add(:end_date, "cannot be before the start date") 
        end
    end
    
    def welcome
        puts "#{User.find(customer_id).first_name}, profitez bien de votre séjour"
    end

    def duration
        duration = ((end_date - start_date) / 86400).to_i
        puts "Votre voyage durera #{duration} jours"
    end

    def overlaps?
        if (Trip.where("(? BETWEEN start_date AND end_date OR ? BETWEEN start_date AND end_date) AND stay_id = ?", self.start_date, self.end_date, self.stay_id).any?)
            errors.add(:end_date, 'it overlaps another reservation')
        end
    end
end

