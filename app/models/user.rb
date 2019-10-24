class User < ApplicationRecord
  has_secure_password
  has_many :registrations, :dependent  => :destroy 
  has_many :events, through: :registrations
  has_many :likes, dependent: :destroy
  has_many :liked_events, through: :likes, source: :event
  has_many :comments, dependent: :destroy 
  has_many :events, through: :comments
  validates :name, presence: true 
  validates :email, presence: true, uniqueness: true, format: { with:/(\S+)@(\S+)/ } 
  validates :password, presence: true, length: { within: 8...32 }

  def self.authenticate(email, password)
  	user = User.find_by(email: email)
  	user && user.authenticate(password)
  end
end
