class AddRatingToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :rating, :integer, array: :true, default: [], null: false
    add_column :products, :rate_user, :integer, array: :true, default: [], null: false
  end
end
