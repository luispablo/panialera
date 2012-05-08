class CreateDetallesCompras < ActiveRecord::Migration
  def change
    create_table :detalles_compras do |t|
      t.references :compra
      t.references :producto
      t.integer :cantidad
      t.float :precio

      t.timestamps
    end
    add_index :detalles_compras, :compra_id
    add_index :detalles_compras, :producto_id
  end
end
