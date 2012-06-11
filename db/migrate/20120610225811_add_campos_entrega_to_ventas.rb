class AddCamposEntregaToVentas < ActiveRecord::Migration
  def change
    add_column :ventas, :fecha_entrega, :date

    add_column :ventas, :hora_desde_entrega, :time

    add_column :ventas, :hora_hasta_entrega, :time

  end
end
