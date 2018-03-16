class AddAdressToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :adress, :text
  end
end
