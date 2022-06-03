class AddColumnToLikes < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :updated_date, :timestamp
  end
end
