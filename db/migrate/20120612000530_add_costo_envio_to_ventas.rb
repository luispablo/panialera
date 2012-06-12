class AddCostoEnvioToVentas < ActiveRecord::Migration
  def change
    add_column :ventas, :costo_envio, :float

  end
end
