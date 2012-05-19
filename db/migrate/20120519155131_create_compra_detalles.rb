class CreateCompraDetalles < ActiveRecord::Migration
  def change
    create_table :compra_detalles do |t|
      t.references :compra
      t.references :producto
      t.float :cantidad
      t.float :precio

      t.timestamps
    end
    add_index :compra_detalles, :compra_id
    add_index :compra_detalles, :producto_id
  end
end
