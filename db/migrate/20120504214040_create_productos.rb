class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :codigo
      t.string :nombre
      t.string :descripcion
      t.string :detalle
      t.float :precio
      t.string :referencia
      t.boolean :disponible
      t.boolean :publicado

      t.timestamps
    end
  end
end
