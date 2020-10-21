class Reservation < ApplicationRecord
  belongs_to :event
  belongs_to :participant

  validates :event_id, uniqueness: { scope: :participant_id }

  enum attendance_status: {
    未参加: 0,
    参加: 1,
    キャンセル: 2
  }

  

end