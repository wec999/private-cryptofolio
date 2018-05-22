class CreateCoins < ActiveRecord::Migration[5.2]
  def change
    create_table :coins do |t|
      t.string :name
      t.decimal :price
      t.integer :quantity
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
