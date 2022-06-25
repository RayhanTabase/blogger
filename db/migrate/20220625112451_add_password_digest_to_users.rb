class AddPasswordDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string :password_digest    # Be sure to have this in your migration or otherwise the `has_secure_password` won't work!
    end
  end
end
