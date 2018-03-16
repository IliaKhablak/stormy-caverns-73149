class RemoveProductidFromOrder < ActiveRecord::Migration[5.1]
  def change
  	remove_column :orders, :product_id
  end
end
