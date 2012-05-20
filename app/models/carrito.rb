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

  def precio_total
    carrito_items.to_a.sum { |item| item.precio_total }
  end
  
  def agregar_producto(producto_id)
    item_actual = carrito_items.find_by_producto_id(producto_id)
    
    if item_actual
      item_actual.cantidad += 1
    else
      item_actual = carrito_items.build(producto_id: producto_id, cantidad: 1)
    end

    item_actual
  end
end
