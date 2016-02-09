class Donation < ActiveRecord::Base
  belongs_to :user
  belongs_to :cause
  validates :user_id, presence: true
  validates :cause_id, presence: true
  validates :amount, presence: true, numericality: { only_integer: true }

  def username
    User.find(self.user_id).username
  end
end
