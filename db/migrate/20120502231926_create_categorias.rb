class CreateCategorias < ActiveRecord::Migration
  def change
    create_table :categorias do |t|
      t.string :codigo
      t.string :nombre
      t.string :descripcion
      t.references :categoria

      t.timestamps
    end
    add_index :categorias, :categoria_id
  end
end
