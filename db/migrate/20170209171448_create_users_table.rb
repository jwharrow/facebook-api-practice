class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :first_name
      t.string   :last_name
      t.string   :image
      t.bigint   :fb_id
      t.string   :email
      t.string   :hashed_password
      t.text     :profile

      t.timestamps(null: false)
    end
  end
end
