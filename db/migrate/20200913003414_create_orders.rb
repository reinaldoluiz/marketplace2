class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
