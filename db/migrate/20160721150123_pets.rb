class Pets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :type, null: false
      t.string :breed, null: false
      t.integer :age, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.integer :shelter_id, null: false

      t.timestamps null: false
  end
    add_index :pets, :shelter_id
  end
end
