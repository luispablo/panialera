class AddComboToVentaDetalles < ActiveRecord::Migration
  def change
    change_table :venta_detalles do |t|
      t.references :combo
    end
  end
end
