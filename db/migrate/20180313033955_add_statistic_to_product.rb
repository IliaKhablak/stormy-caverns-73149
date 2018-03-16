class AddStatisticToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :statistic, :integer, default: 0, null: false
  end
end
