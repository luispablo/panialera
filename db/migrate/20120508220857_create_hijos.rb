class CreateHijos < ActiveRecord::Migration
  def change
    create_table :hijos do |t|
      t.string :nombre
      t.string :apellido
      t.date :fecha_nacimiento
      t.string :sexo
      t.boolean :usa_paniales
      t.references :usuario

      t.timestamps
    end
    add_index :hijos, :usuario_id
  end
end
