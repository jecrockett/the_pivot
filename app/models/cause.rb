class Cause < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :donations

  def amount_raised
    Donation.where(cause_id: self.id).sum(:amount) || 0
  end
end
