class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.string :address
      t.integer :radius
      t.references :type, foreign_key: true
      t.integer :budget
      t.integer :surface_min
      t.integer :room_min
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
