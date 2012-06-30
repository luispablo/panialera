class RemoveUsuarioFromCompras < ActiveRecord::Migration
  def change    
    remove_column :compras, :usuario
    remove_column :compras, :domicilio
  end
end
