class Movie < ActiveRecord::Base
    def self.list_all_ratings
        Movie.select(:rating).map(&:rating).uniq
    end
end
