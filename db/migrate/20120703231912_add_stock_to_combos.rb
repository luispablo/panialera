class AddStockToCombos < ActiveRecord::Migration
  def change
    add_column :combos, :stock, :float

  end
end
