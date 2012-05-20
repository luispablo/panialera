class AddCantidadToCarritoItems < ActiveRecord::Migration
  def change
    add_column :carrito_items, :cantidad, :float

  end
end
