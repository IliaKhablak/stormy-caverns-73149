class CreateBuckets < ActiveRecord::Migration[5.1]
  def change
    create_table :buckets do |t|
      t.integer :user_id
      t.integer :product_id, array: true, default: []

      t.timestamps
    end
  end
end
