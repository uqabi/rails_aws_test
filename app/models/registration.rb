class Registration < ApplicationRecord
  belongs_to :event
  belongs_to :user
  scope :already_registered?, -> (user_id, event_id) { where(:user_id => user_id ).where(:event_Id => event_id)}
end
