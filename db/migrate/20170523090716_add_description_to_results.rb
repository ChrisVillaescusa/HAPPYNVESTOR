class AddDescriptionToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :description, :text
  end
end
