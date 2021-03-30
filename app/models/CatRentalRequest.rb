# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CatRentalRequest < ApplicationRecord
    validates :cat_id, :start_date, :end_date, :status, presence: true
    validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
    validate :does_not_overlap_approved_requests
    belongs_to :cat, dependent: :destroy

    def overlapping_requests
        CatRentalRequest.where("id != ?", self.id)
        .where(cat_id: cat_id)
        .where.not("start_date > :end_date OR end_date < :start_date", 
        end_date: end_date, start_date: start_date)
    end

    def overlapping_approved_requests
        overlapping_requests.where("status = ?", "APPROVED")
    end

    def does_not_overlap_approved_requests
        if overlapping_approved_requests.exists?
            unless self.status == "DENIED"
                errors.add(:start_date, "cannot overlap prior approved request")
            end
        end
    end

    def overlapping_pending_requests
        overlapping_requests.where("status = ?", "PENDING")
    end

    def approve!
        transaction do
            self.update!(status: "APPROVED")
            overlapping_pending_requests.each do |req|
                req.update!(status: "DENIED")
            end
        end
    end

    def deny!
        self.update!(status: "DENIED")
    end

    def pending?
        self.status == "PENDING"
    end

end
