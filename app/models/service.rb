class Service < ApplicationRecord
  belongs_to :venue


  validates_inclusion_of :technical_equipment, :furniture, :decoration, :cleaning_after_event, :security, in: [true, false], allow_nil: true

  validates :additional_services, length: { maximum: 1000 }, allow_blank: true
end
