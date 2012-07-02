class CreateExcepcionEntregas < ActiveRecord::Migration
  def change
    create_table :excepcion_entregas do |t|
      t.date :fecha
      t.time :hora_desde
      t.time :hora_hasta

      t.timestamps
    end
  end
end
