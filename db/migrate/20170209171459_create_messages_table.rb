class CreateMessagesTable < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :receiver_id, null: false
      t.integer :sender_id, null: false
      t.string :status
      t.text :message
      t.boolean :has_flag

      t.timestamps(null: false)
    end
  end
end
