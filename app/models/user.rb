class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.reg.email
  USER_PARAMS = [:name, :email, :password, :password_confirmation].freeze
  PASSWORD_PARAMS = [:password, :password_confirmation].freeze
  attr_accessor :remember_token
  before_save :email_downcase
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :products, dependent: :destroy
  validates :name, presence: true, length: {maximum: Settings.name.maximum}
  validates :email, format: {with: VALID_EMAIL_REGEX},
                             presence: true, uniqueness: true, length: { maximum: Settings.email.maximum}
  validates :password, presence: true, length: {minimum: Settings.password.minimum}, allow_nil: true
  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def activate
    update_attributes activated: true, activated_at: Time.zone.now
  end

  private
  def email_downcase
    email.downcase!
  end
end
