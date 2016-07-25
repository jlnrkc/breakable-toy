class Shelters < ActiveRecord::Migration
  def change
    create_table :shelters do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.string :petfinder_id

      t.timestamps null: false
    end
  end
end
