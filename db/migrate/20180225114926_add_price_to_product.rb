class AddPriceToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :price, :integer, nill: false, default: 0
  end
end
