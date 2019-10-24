class AddLikesCountToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :likes_count, :string
  end
end
