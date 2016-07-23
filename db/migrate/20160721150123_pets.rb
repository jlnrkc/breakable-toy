class Pets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.integer :animal_type, null: false
      t.string :breed, null: false
      t.integer :age, null: false
      t.integer :sex, null: false
      t.string :name, null: false
      t.string :location, null: false
      t.text :description, null: false
      t.integer :shelter_id, null: false

      t.timestamps null: false
  end
    add_index :pets, :shelter_id
  end
end
