class Reservation < ApplicationRecord
  belongs_to :event
  belongs_to :participant

  validates :event_id, uniqueness: { scope: :participant_id }

  enum attendance_status: {
    未参加: 0,
    参加: 1,
    キャンセル: 2
  }

  validate :max_reserve_restrictions
  def max_reserve_restrictions
    if event.number_of_reservations < participant_id
      errors.add(:base, ": 申し訳ございません、予約がいっぱいです。")
    end
  end

end
