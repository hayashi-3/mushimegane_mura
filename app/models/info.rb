class Info < ApplicationRecord
  belongs_to :participant

  with_options presence: true do
    validates :message
  end
end
