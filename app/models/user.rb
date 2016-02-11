class User < ActiveRecord::Base
  has_many :donations
  has_many :causes
  validates :username, presence: true, length: { maximum: 25 }
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: valid_email_regex },
                    uniqueness: { case_sensitive: false }
  enum role: %w(default admin)
  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def supported_causes
    self.donations.map do |donation|
      Cause.find(donation.cause_id)
    end
  end

  def self.from_omniauth(auth_info)
    where(id: auth_info[:uid]).first_or_create do |new_user|
      new_user.id = auth_info.uid
      new_user.username = auth_info.extra.raw_info.screen_name
      new_user.email = auth_info.info.email
      new_user.email = "#{new_user.username}@dreambuilder.com" if new_user.email.nil?
      new_user.password_digest = SecureRandom.base64
      new_user.oauth_token = auth_info.credentials.token
      new_user.oauth_token_secret = auth_info.credentials.secret
    end
  end
end
