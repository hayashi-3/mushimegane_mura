class Participant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :reservations, dependent: :destroy
  has_many :reserved_events, through: :reservation, source: :event 
  
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

end
