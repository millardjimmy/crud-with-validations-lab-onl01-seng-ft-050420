class Song < ApplicationRecord
    validates :title, presence: true
    validates :title, uniqueness: { scope: [:artist_name, :release_year],
        message: "Cannot release the same song twice in a year."
    }
    validates :released, inclusion: { in: [ true, false ] }
    validates :artist_name, presence: true
    validate :release_year_validator

private

    def release_year_validator
        if self.released
            unless self.release_year
                errors.add(:release_year, "Songs must have a release year.")
            else
                t = Time.new
                if t.year < self.release_year
                    errors.add(:release_year, "Songs cannot be released from the future.")
                end
            end
        end
    end
end