class AddOfertaToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :oferta, :boolean

  end
end
