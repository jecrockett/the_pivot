class Cause < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :donations
  has_many :cause_admins
  has_many :users, through: :cause_admins
end
