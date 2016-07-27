class Pets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.integer :animal_type, null: false
      t.string :breed
      t.integer :age
      t.integer :sex
      t.string :size
      t.string :name, null: false
      t.string :location
      t.text :description
      t.string :petfinder_id
      t.integer :shelter_id

      t.timestamps null: false
  end
    add_index :pets, :shelter_id
  end
end
