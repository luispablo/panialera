class AddOrdenToCategorias < ActiveRecord::Migration
  def change
    add_column :categorias, :orden, :integer

  end
end
