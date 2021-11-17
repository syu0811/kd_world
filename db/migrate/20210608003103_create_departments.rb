class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments do |t|
      t.string :name, null: false
      t.string :alphabet, null: false
      t.timestamps
    end

    add_index :departments, [:name, :alphabet], unique: true
  end
end
