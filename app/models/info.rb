class Info < ApplicationRecord
  belongs_to :participant

  validates :message, presence: true
end
