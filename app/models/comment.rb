class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :comment, presence: true
end
