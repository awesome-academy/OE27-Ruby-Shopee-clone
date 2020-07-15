class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.reg.email
  USER_PARAMS = [:name, :email, :password, :password_confirmation].freeze
  PASSWORD_PARAMS = [:password, :password_confirmation].freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :async

  attr_accessor :remember_token
  before_save :email_downcase
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :products, dependent: :destroy
  validates :name, presence: true, length: {maximum: Settings.name.maximum}
  validates :email, format: {with: VALID_EMAIL_REGEX},
                             presence: true, uniqueness: true, length: { maximum: Settings.email.maximum}
  validates :password, presence: true, length: {minimum: Settings.password.minimum}, allow_nil: true

  private

  def email_downcase
    email.downcase!
  end
end
