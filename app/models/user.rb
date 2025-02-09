class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :venues, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :omniauthable, omniauth_providers: [:telegram]
  
  has_one :profile, dependent: :destroy
  ROLES = %w[user landlord moderator admin].freeze
  enum role: { user: 'user', landlord: 'landlord',moderator: 'moderator',admin: 'admin' }
  validates :role, inclusion: { in: ROLES }

  # def admin?
  #   role == "admin"
  # end

  # def moderator?
  #   role == "moderator"
  # end

  # def landlord?
  #   role == "landlord"
  # end

  # def user?
  #   role == "user"
  # end
  private

  def password_present?
    password.present?
  end
end
