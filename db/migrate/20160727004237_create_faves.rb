class CreateFaves < ActiveRecord::Migration
  def change
    create_table :faves do |t|
      t.integer :user_id
      t.integer :pet_id
    end

    add_index :faves, :user_id
    add_index :faves, :pet_id
    add_index :faves, [:user_id, :pet_id], unique: true
  end
end
