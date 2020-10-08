class Event < ApplicationRecord
  has_many :reservations, dependent: :destroy
  accepts_nested_attributes_for :reservations, allow_destroy: true
end
