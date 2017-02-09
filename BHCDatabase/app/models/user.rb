class User < ApplicationRecord

  has_many :enrolments
  has_many :initiatives, through: :enrolments

  has_many :attendances
  has_many :meetings, through: :attendances

  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates :telephone, presence: true, length: { maximum: 16 }
  validates :dob, presence: true
  validates :privilege, presence: true, numericality: { only_integer: true,
                                                        greater_than_or_equal_to: 0,
                                                        less_than_or_equal_to: 3 }

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
