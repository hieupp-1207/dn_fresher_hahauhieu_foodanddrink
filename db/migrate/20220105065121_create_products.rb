class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :image
      t.float :price
      t.integer :quantity
      t.float :rating

      t.timestamps
    end
  end
end
