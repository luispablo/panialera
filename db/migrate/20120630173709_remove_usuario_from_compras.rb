class RemoveUsuarioFromCompras < ActiveRecord::Migration
  def change    
    remove_column :compras, :usuario_id
    remove_column :compras, :domicilio_id
  end
end
