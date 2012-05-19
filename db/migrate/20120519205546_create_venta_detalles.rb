class CreateVentaDetalles < ActiveRecord::Migration
  def change
    create_table :venta_detalles do |t|
      t.references :venta
      t.references :producto
      t.float :cantidad
      t.float :precio

      t.timestamps
    end
    add_index :venta_detalles, :venta_id
    add_index :venta_detalles, :producto_id
  end
end
