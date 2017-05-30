class AddPhotoToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :img, :string
  end
end
