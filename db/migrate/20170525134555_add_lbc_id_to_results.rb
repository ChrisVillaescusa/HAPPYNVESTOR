class AddLbcIdToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :lbc_id, :string
  end
end
