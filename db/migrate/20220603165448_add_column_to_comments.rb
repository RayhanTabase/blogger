class AddColumnToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :text, :text
    add_column :comments, :updated_date, :timestamp
  end
end
