class AddEntregadaToVentas < ActiveRecord::Migration
  def change
    add_column :ventas, :entregada, :boolean

  end
end
