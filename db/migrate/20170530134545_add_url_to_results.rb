class AddUrlToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :url, :string
  end
end
