class Facility < ApplicationRecord
  belongs_to :venue

  validates :wifi, :air_conditioning, :audio_visual_equipment, :parking, 
            :disabled_access, :kitchen, inclusion: { in: [true, false] }

  validates :toilets_count, numericality: { 
    only_integer: true, 
    greater_than_or_equal_to: 0, 
    message: "Количество туалетов должно быть целым числом и не меньше нуля"
  }
          
  validates :other_facilities, length: { maximum: 1500 }, allow_blank: true
end
