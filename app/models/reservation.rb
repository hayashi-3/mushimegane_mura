class Reservation < ApplicationRecord
  belongs_to :event
  belongs_to :participant

  enum attendance_status: {
    不参加: 0,
    参加: 1,
  }

end
