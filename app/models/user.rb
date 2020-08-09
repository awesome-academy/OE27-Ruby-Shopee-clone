class User < ApplicationRecord
  acts_as_paranoid
  VALID_EMAIL_REGEX = Settings.reg.email
  USER_PARAMS = [:name, :email, :password, :password_confirmation].freeze
  PASSWORD_PARAMS = [:password, :password_confirmation].freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:github]

  attr_accessor :remember_token
  before_save :email_downcase
  has_many :orders
  has_many :reviews
  has_many :products
  validates :name, presence: true, length: {maximum: Settings.name.maximum}
  validates :email, format: {with: VALID_EMAIL_REGEX},
                             presence: true, uniqueness: true, length: { maximum: Settings.email.maximum}
  validates :password, presence: true, length: {minimum: Settings.password.minimum}, allow_nil: true

  scope :order_by_deleted, -> {order deleted_at: :asc}

  class << self
    def from_omniauth access_token
      data = access_token.info
      result = User.find_by email: data.email
      return result if result

      password = Devise.friendly_token[0,20]
      where(provider: access_token.provider, uid: access_token.uid).first_or_create do |user|
        user.email = data.email
        user.password = password
        user.password_confirmation = password
        user.name = data.name
        user.confirmation_sent_at = Time.now
        user.confirmed_at = Time.now
      end
    end
  end

  private

  def email_downcase
    email.downcase!
  end
end
