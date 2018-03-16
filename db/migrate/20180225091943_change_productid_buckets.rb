class ChangeProductidBuckets < ActiveRecord::Migration[5.1]
  def change
  	change_column :buckets, :product_id, :integer, array: true, default: [], null: false
  end
end
