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
    if date_and_time.present? && date_and_time < DateTime.now
      errors.add(:date_and_time, "この日付は使用できません")
    end
  end

  scope :search, -> (search_params) do      #scopeでsearchメソッドを定義。(search_params)は引数
    return if search_params.blank?      #検索フォームに値がなければ以下の手順は行わない

    event_name_like(search_params[:event_name])
      .date_and_time_from(search_params[:date_and_time_from])#下記で定義しているscopeメソッドの呼び出し。「.」で繋げている
      .date_and_time_to(search_params[:date_and_time_to])
  end

  scope :event_name_like, -> (event_name) { where('event_name LIKE ?', "%#{event_name}%") if event_name.present? }  #scopeを定義
  scope :date_and_time_from, -> (from) { where('? <= date_and_time', from) if from.present? }
  scope :date_and_time_to, -> (to) { where('date_and_time < ?', (Date.parse(to)+1).to_s) if to.present? }
  # ('? <= date_and_time', from)の場合は日付の取得が◯月◯日の０時０分以下になってしまう。その為、< 実際に検索した日付+1日未満のものを探すようにする。
  # 入力された値(to)は文字列になっている為、日付に変換する。parseにて(to)を変換＋１して.to_sで文字列に変換する
end