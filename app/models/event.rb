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

  scope :search, -> (search_params) do      #scopeでsearchメソッドを定義。(search_params)は引数
    return if search_params.blank?      #検索フォームに値がなければ以下の手順は行わない

    event_name_like(search_params[:event_name])
      .date_and_time(search_params[:date_and_time])#下記で定義しているscopeメソッドの呼び出し。「.」で繋げている
  end

  scope :event_name_like, -> (event_name) { where('event_name LIKE ?', "%#{event_name}%") if event_name.present? }  #scopeを定義。
  scope :date_and_time, -> (date_and_time) { where('date_and_time') if date_and_time.present? }

end