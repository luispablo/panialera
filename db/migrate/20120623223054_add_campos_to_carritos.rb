class AddCamposToCarritos < ActiveRecord::Migration
  def change
    change_table :carritos do |t|
      t.references :domicilio
      t.date :fecha_entrega
      t.time :hora_desde_entrega
      t.time :hora_hasta_entrega
    end
  end
end
