class AddLikesToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :like, :string, array: true
  end
end
