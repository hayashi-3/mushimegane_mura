class Reservation < ApplicationRecord
  belongs_to :event
  belongs_to :participant

  validates :event_id, uniqueness: { scope: :participant_id }

  enum attendance_status: {
    not_resarve: 0,
    reserve: 1,
  }

end