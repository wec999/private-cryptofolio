class AddSymbolToCoins < ActiveRecord::Migration[5.2]
  def change
    add_column :coins, :symbol, :string
  end
end
