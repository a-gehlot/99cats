# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
include ActionView::Helpers::DateHelper

class Cat < ApplicationRecord
    COLORS = ["black", "white", "grey", "calico", "red"]
    validates :birth_date, :color, :name, :sex, :description, presence: true
    validates :sex, inclusion: { in: %w(M F) } 
    validates :color, inclusion: { in: COLORS }
    has_many :cat_rental_requests, dependent: :destroy

    def age
        time_ago_in_words(self.birth_date)
    end

end
