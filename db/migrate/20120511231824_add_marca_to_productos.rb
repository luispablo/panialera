class AddMarcaToProductos < ActiveRecord::Migration
  def change
    change_table :productos do |t|
      t.references :marca
    end
  end
end
