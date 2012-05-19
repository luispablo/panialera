class CreateCatProductos < ActiveRecord::Migration
  def change
    create_table :cat_productos do |t|
      t.references :producto
      t.references :categoria

      t.timestamps
    end
    add_index :cat_productos, :producto_id
    add_index :cat_productos, :categoria_id
  end
end
