class Event < ApplicationRecord

  has_many :reservations, dependent: :destroy
  has_many :reserving_participants, through: :reservation, source: :participant
  has_many :event_comments, dependent: :destroy
  
  accepts_nested_attributes_for :reservations, allow_destroy: true
  
  attachment :image

  def reserved_by?(participant)
    reservations.where(participant_id: participant.id).exists?
  end

  def end_of_event
    end_of_event_ids = Event.where.not(date_and_time: nil).pluck(:id)
    @held_events = Event.where(id: end_of_event_ids).where('date_and_time <= ?', DateTime.now.to_time)
  end

  validates :date_and_time, :event_name, :content, :number_of_reservations, :is_active, presence: true

  validate :date_cannot_be_in_the_past
  def date_cannot_be_in_the_past
    if date_and_time.present? && date_and_time < DateTime.now.to_time
      errors.add(:date_and_time, "この日付は使用できません")
    end
  end

end