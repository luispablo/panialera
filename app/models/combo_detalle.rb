# == Schema Information
#
# Table name: combo_detalles
#
#  id          :integer         not null, primary key
#  producto_id :integer
#  cantidad    :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  combo_id    :integer
#

class ComboDetalle < ActiveRecord::Base
  belongs_to :producto
  belongs_to :combo
  
  def cuantos_se_pueden_armar
    stock = producto.stock_disponible
    ((stock.nil? ? 0 : stock) / (cantidad.nil? ? 1 : cantidad)).floor
  end
  
  def agregar_stock(cantidad_combo)
    producto.agregar_stock cantidad_combo * cantidad
    producto.save  
  end
  
  def quitar_stock(cantidad_combo)
    producto.quitar_stock cantidad_combo * cantidad
    producto.save
  end 
  
  def precio_real
    unless cantidad.nil?
      producto.precio * cantidad
    else
        0
    end 
  end
end
