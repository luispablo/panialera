class AddAdministradorToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :administrador, :boolean

  end
end
