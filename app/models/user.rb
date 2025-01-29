class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :venues, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :omniauthable, omniauth_providers: [:telegram]
  
  has_one :profile, dependent: :destroy

  def days_registered
    (Date.current - created_at.to_date).to_i
  end

  private

  def password_present?
    password.present?
  end
end
