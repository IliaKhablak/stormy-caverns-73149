class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.integer :product_id
      t.attachment :image

      t.timestamps
    end
  end
end
