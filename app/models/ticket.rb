class Ticket < ApplicationRecord
  belongs_to :event

  TICKET_TYPES = {
    'standard' => 'Стандартный',
    'vip' => 'VIP',
    'early_bird' => 'Ранняя регистрация'
  }.freeze

  CURRENCIES = {
    'RUB' => 'Рубль (₽)',
    'USD' => 'Доллар ($)',
    'EUR' => 'Евро (€)'
  }.freeze

  PAYMENT_METHODS = {
    'card' => 'Банковская карта',
    'cash' => 'Наличные',
    'transfer' => 'Банковский перевод'
  }.freeze

  validates :ticket_type, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  # validates :currency, presence: true, inclusion: { in: CURRENCIES.keys, message: "%{value} не может быть использована" }
  validates :payment_method, presence: true, length: { minimum: 1 }

  CURRENCY_TYPES = [
    '₽', '€', '$', '£'
  ]

  # validates :currency, presence: true, inclusion: { in: CURRENCY_TYPES, message: "%{value}, не может быть использована"  }
  # validates :discount_code, allow_nil: true, format: { with: /\A[a-zA-Z0-9]+\z/, message: "only allows alphanumeric characters" }
end
