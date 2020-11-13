class Participant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :nickname, :telephone_number, presence: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_acceptance_of :agreement, allow_nil: false, on: :create

  def self.guest
    find_or_create_by!(nickname: 'ゲスト', telephone_number: '09098766543', email: 'guest@example.com') do |participant|
      participant.password = SecureRandom.urlsafe_base64
    end
  end
  
  has_many :reservations, dependent: :destroy
  has_many :reservation
  has_many :reserved_events, through: :reservation, source: :event
  has_many :event_comments, dependent: :destroy
  has_many :infos
  
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

end