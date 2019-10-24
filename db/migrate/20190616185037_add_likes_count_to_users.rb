class AddLikesCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :likes_count, :string
  end
end
