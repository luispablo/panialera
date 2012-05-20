class AddPublicadoToCategorias < ActiveRecord::Migration
  def change
    add_column :categorias, :publicado, :boolean

  end
end
