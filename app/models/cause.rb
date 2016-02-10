class Cause < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :donations

  validates :description, presence: true
  validates :goal, presence: true
  validates :title, presence: true
  validates :goal, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true
  validates :category_id, presence: true

  # pagination setting
  self.per_page = 6
  
  def amount_raised
    cause_donations.sum(:amount) || 0
  end

  def donation_count
    cause_donations.count
  end

  def total_supporters
    cause_donations.pluck(:user_id).uniq.count
  end

  def self.active_causes
    where(current_status: "active")
  end

  def self.active_causes_for_category(params)
    where(category_id: params[:id], current_status: "active")
  end

  def self.pending_causes
    where(current_status: "pending")
  end

  private

    def cause_donations
      Donation.where(cause_id: self.id)
    end
end
