class AddFieldsToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :stock, :integer

    add_column :productos, :talle, :string

    add_column :productos, :peso_bebe, :string

    add_column :productos, :edad_bebe, :string

  end
end
