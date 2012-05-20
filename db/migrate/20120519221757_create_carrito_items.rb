class CreateCarritoItems < ActiveRecord::Migration
  def change
    create_table :carrito_items do |t|
      t.references :producto
      t.references :carrito

      t.timestamps
    end
    add_index :carrito_items, :producto_id
    add_index :carrito_items, :carrito_id
  end
end
