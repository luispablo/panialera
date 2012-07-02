class AddComboToCarritoItems < ActiveRecord::Migration
  def change
    change_table :carrito_items do |t|
      t.references :combo
    end
  end
end
