class Category < ActiveRecord::Base
  has_many :causes
  validates :title, uniqueness: true, presence: true
end
