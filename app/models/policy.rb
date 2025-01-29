class Policy < ApplicationRecord
  belongs_to :venue

  # validates :smoking_allowed, :alcohol_allowed, :noise_restrictions, inclusion: { in: [true, false] }
end
