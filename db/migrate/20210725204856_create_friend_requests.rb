class CreateFriendRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_requests do |t|
      t.references :user, null: false
      t.references :applicant, null: false
      t.timestamps
    end

    add_foreign_key :friend_requests, :users, column: :user_id
    add_foreign_key :friend_requests, :users, column: :applicant_id

    add_index :friend_requests, [:user_id, :applicant_id], unique: true
  end
end
