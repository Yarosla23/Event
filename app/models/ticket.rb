class Ticket < ApplicationRecord
  belongs_to :event

  validates :ticket_type, presence: true, inclusion: { in: ['Standard', 'VIP', 'Early Bird'], message: "%{value} is not a valid ticket type" }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :currency, presence: true, length: { is: 3 }
  validates :payment_method, presence: true, inclusion: { in: ['Credit Card', 'PayPal', 'Bank Transfer'], message: "%{value} is not a valid payment method" }
  validates :discount_code, allow_nil: true, format: { with: /\A[a-zA-Z0-9]+\z/, message: "only allows alphanumeric characters" }
end
