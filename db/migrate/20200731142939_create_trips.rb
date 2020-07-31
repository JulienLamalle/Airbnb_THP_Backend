class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.belongs_to :stay, index: true
      t.references :host, index: true
      t.references :customer, index: true
      t.timestamps
    end
  end
end
