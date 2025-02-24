class Information < ApplicationRecord
  belongs_to :venue

  validates :document, length: { maximum: 500 }, allow_blank: true
  validates :description, length: { maximum: 1000 }, allow_blank: true
  validates :calendar, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "должна быть ссылка" }, allow_blank: true
  validates :restrictions, length: { maximum: 1000 }, allow_blank: true


  validates_inclusion_of :smoking_allowed, :alcohol_allowed, :noise_restrictions, in: [true, false], allow_nil: true
end
