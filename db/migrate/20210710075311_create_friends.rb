class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|
      t.references :user, null: false
      t.references :friend, null: false
      t.timestamps
    end

    add_foreign_key :friends, :users, column: :user_id
    add_foreign_key :friends, :users, column: :friend_id

    add_index :friends, [:user_id, :friend_id], unique: true
  end
end
