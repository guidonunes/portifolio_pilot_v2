class AddIndexesForPerformance < ActiveRecord::Migration[7.1]
  def change
    # Add index on holdings for asset_type to speed up filtering
    add_index :holdings, :asset_type unless index_exists?(:holdings, :asset_type)
    
    # Add index on operations for quantity and price (used in calculations)
    add_index :operations, [:wallet_id, :holding_id] unless index_exists?(:operations, [:wallet_id, :holding_id])
    
    # Add index on holdings current_price for faster lookups
    add_index :holdings, :current_price unless index_exists?(:holdings, :current_price)
  end
end
