class AddColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :comments_count, :integer
  end
end
