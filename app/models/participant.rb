class Participant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :telephone_number, presence: true
  
  has_many :reservations, dependent: :destroy
  has_many :reservation
  has_many :reserved_events, through: :reservation, source: :event
  has_many :event_comments, dependent: :destroy
  has_many :infos
  
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

end