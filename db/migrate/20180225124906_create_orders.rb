class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.boolean :complit, default: false
      t.integer :price
      t.string :product_id, array: true, default: [], nill: false

      t.timestamps
    end
  end
end
