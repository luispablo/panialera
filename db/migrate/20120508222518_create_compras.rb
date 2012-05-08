class CreateCompras < ActiveRecord::Migration
  def change
    create_table :compras do |t|
      t.timestamp :fecha
      t.references :usuario
      t.references :domicilio

      t.timestamps
    end
    add_index :compras, :usuario_id
    add_index :compras, :domicilio_id
  end
end
