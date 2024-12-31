class User < ApplicationRecord
  
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
