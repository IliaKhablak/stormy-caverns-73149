class CreateCategoryes < ActiveRecord::Migration[5.1]
  def change
    create_table :categoryes do |t|
      t.string :title
      t.timestamps
    end
  end
end
