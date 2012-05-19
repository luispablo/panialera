class CreateVentas < ActiveRecord::Migration
  def change
    create_table :ventas do |t|
      t.date :fecha
      t.references :usuario
      t.references :domicilio

      t.timestamps
    end
    add_index :ventas, :usuario_id
    add_index :ventas, :domicilio_id
  end
end
