class Event < ApplicationRecord
	scope :event_of_the_month, -> { order("likes_count DESC").first  }
	scope :recent_events, -> { where('starts_at < ?', Time.now).order('starts_at') }
	scope :upcoming_events, -> { where('starts_at > ?', Time.now).order('starts_at').all }
	has_many :registrations, dependent: :destroy 
	has_many :users, through: :registrations
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user
    has_many :comments, dependent: :destroy 
    has_many :users, through: :comments
    has_many :categorizations, dependent: :destroy 
    has_many :categories, through: :categorizations
	validates :name, presence: true 
	validates :location, presence: true 
	validates :starts_at, presence: true 
	validates :description, presence: true 
	validates :image, presence: true
	mount_uploader :image, ImageUploader
 
# validate :validate_minimum_image_size

# def validate_minimum_image_size
#   image = MiniMagick::Image.open(image.path)
#   unless image[:width] > 400 && image[:height] > 400
#     errors.add :image, "should be 400x400px minimum!" 
#   end
# end
before_validation :create_slug
def to_param
	slug
end
def create_slug
 self.slug ||= name.parameterize if name
end

end