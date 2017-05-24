class AddScrappingidToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :sl_id, :string
  end
end
