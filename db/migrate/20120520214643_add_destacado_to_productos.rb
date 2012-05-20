class AddDestacadoToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :destacado, :boolean

  end
end
