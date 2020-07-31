class CreateStays < ActiveRecord::Migration[5.2]
  def change
    create_table :stays do |t|
      t.integer :nb_beds
      t.float :night_price
      t.text :description
      t.boolean :wifi
      t.belongs_to :city, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
