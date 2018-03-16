class AddCompareToWishlist < ActiveRecord::Migration[5.1]
  def change
  	    add_column :wishlists, :compare, :integer, array: :true, default: [], nul: false
  end
end
