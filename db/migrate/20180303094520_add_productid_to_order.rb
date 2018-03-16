class AddProductidToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :product_id, :integer, array: :true, default: [], nul: false
  end
end
