class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.integer :price
      t.string :address
      t.integer :room_number
      t.integer :surface
      t.references :search, foreign_key: true

      t.timestamps
    end
  end
end
