class Event < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :reserving_participants, through: :reservation, source: :participant
  accepts_nested_attributes_for :reservations, allow_destroy: true
  
  attachment :image
end
