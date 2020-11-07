class Event < ApplicationRecord

  has_many :reservations, dependent: :destroy
  has_many :reserving_participants, through: :reservation, source: :participant
  has_many :event_comments, dependent: :destroy
  
  accepts_nested_attributes_for :reservations, allow_destroy: true
  
  attachment :image

  def reserved_by?(participant)
    reservations.where(participant_id: participant.id).exists?
  end

  validates :date_and_time, :event_name, :content, :number_of_reservations, presence: true
  validates :number_of_reservations, numericality: { greater_than_or_equal_to: 1 }
  validates :is_active, inclusion: {in: [true, false]}

  validate :date_cannot_be_in_the_past
  def date_cannot_be_in_the_past
    if date_and_time.present? && date_and_time < DateTime.now.to_time
      errors.add(:date_and_time, "この日付は使用できません")
    end
  end

  def self.search(search,word)
    if search == "forward_match"
      @event = Event.where("event_name LIKE?","#{word}%")
    elsif search == "backward_match"
      @event = Event.where("event_name LIKE?","%#{word}")
    elsif search == "perfect_match"
      @event = Event.where("#{word}")
    elsif search == "partial_match"
      @event = Event.where("event_name LIKE?","%#{word}%")
    else
      @event = Event.all
    end
  end

end