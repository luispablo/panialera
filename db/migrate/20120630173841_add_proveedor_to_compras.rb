class AddProveedorToCompras < ActiveRecord::Migration
  def change
    change_table :compras do |t|
      t.references :proveedor
    end
  end
end
