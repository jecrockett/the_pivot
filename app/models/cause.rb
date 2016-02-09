class Cause < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :donations

  def amount_raised
    Donation.where(cause_id: self.id).sum(:amount) || 0
  end

  def donation_count
    Donation.where(cause_id: self.id).count
  end

  def total_supporters
    Donation.where(cause_id: self.id).pluck(:user_id).uniq.count
  end

  def supporters
    supporters = Donation.where(cause_id: self.id).pluck(:user_id)
    supporters.map {|suppporter| User.find(suppporter)}
  end

  def self.active_causes
    where(current_status: "active")
  end

  def self.pending_causes
    where(current_status: "pending")
  end
end
