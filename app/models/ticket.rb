class Ticket < ApplicationRecord
  belongs_to :event
  CURRENCY_TYPES = [
    '₽', '€', '$', '£'
  ]

  PAYMENT_METHODS = [
    'Полная оплата', 'Без залогов', 'Предоплата'
  ]

  validates :ticket_type, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :currency, presence: true, inclusion: { in: CURRENCY_TYPES, message: "%{value}, не может быть использована"  }
  validates :payment_method, presence: true, inclusion: { in: PAYMENT_METHODS, message: "%{value} is not a valid payment method" }
  # validates :discount_code, allow_nil: true, format: { with: /\A[a-zA-Z0-9]+\z/, message: "only allows alphanumeric characters" }
end
