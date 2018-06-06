class AddCoinmarketcapidToCoins < ActiveRecord::Migration[5.2]
  def change
    add_column :coins, :cmarketcap_id, :integer
  end
end
