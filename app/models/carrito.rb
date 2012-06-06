# == Schema Information
#
# Table name: carritos
#
#  id         :integer         not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Carrito < ActiveRecord::Base
  has_many :carrito_items, dependent: :destroy

  def costo_envio
    if self.precio_total >= Parametro.monto_minimo_sin_envio
      0
    else
      Parametro.precio_envio
    end    
  end

  def precio_total
    carrito_items.to_a.sum { |item| item.precio_total }
  end
  
  def agregar_producto(producto_id, cantidad)
    item_actual = carrito_items.find_by_producto_id(producto_id)
    
    if item_actual
      item_actual.cantidad += cantidad
    else
      item_actual = carrito_items.build(producto_id: producto_id, cantidad: cantidad)
    end

    item_actual
  end
end
