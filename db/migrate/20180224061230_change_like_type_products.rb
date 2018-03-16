class ChangeLikeTypeProducts < ActiveRecord::Migration[5.1]
  def change
  	change_column :products, :like, :string, array: true, default: []
  end
end
