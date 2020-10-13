class Event < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :reserving_participants, through: :reservation, source: :participant
  has_many :event_comments, dependent: :destroy
  
  accepts_nested_attributes_for :reservations, allow_destroy: true
  
  attachment :image

  validate :date_cannot_be_in_the_past

  private

  def date_cannot_be_in_the_past
    if date_and_time.present? && date_and_time < Date.today
      errors.add(:date_and_time, "過去の日付は使用できません")
    end
  end

end
