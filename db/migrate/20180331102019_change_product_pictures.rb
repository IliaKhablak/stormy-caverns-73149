class ChangeProductPictures < ActiveRecord::Migration[5.1]
  def change
  	remove_column :products, :images
  	remove_column :products, :avatar
  	add_column :products, :images, :string, array: :true, default: []
  end
end
