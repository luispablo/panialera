class ChangeStockInProductos < ActiveRecord::Migration
  def change
    change_table :productos do |t|
      t.remove :stock
      t.float :stock
    end
  end
end
