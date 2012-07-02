class AddPaginaWebToProveedores < ActiveRecord::Migration
  def change
    add_column :proveedores, :pagina_web, :string

  end
end
