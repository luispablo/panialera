class CreateProveedores < ActiveRecord::Migration
  def change
    create_table :proveedores do |t|
      t.string :nombre
      t.string :direccion
      t.string :telefono
      t.string :email

      t.timestamps
    end
  end
end
