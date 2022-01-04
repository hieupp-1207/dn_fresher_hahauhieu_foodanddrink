class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :status, default: 0
      t.string :address
      t.string :phone
      t.float :total_price

      t.timestamps
    end
  end
end
