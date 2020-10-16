class EventComment < ApplicationRecord
  belongs_to :event
  belongs_to :participant

  validates :comment, presence: true
end
