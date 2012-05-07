class CreateDomicilios < ActiveRecord::Migration
  def change
    create_table :domicilios do |t|
      t.string :nombre
      t.string :calle
      t.integer :numero
      t.string :piso
      t.string :depto
      t.string :entre_calles
      t.string :codigo_postal
      t.references :barrio

      t.timestamps
    end
    add_index :domicilios, :barrio_id
  end
end
