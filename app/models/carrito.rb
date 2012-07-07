# == Schema Information
#
# Table name: carritos
#
#  id                 :integer         not null, primary key
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  domicilio_id       :integer
#  fecha_entrega      :date
#  hora_desde_entrega :time
#  hora_hasta_entrega :time
#

class Carrito < ActiveRecord::Base
  has_many :carrito_items, dependent: :destroy, autosave: true
  
  validates_associated :carrito_items
  
  belongs_to :domicilio

  def costo_envio
    if carrito_items.empty? or self.precio_total_items >= Parametro.monto_minimo_sin_envio
      0
    else
      Parametro.precio_envio
    end    
  end

  def precio_total_items
    carrito_items.to_a.sum { |item| item.precio_total }
  end

  def precio_total
    precio_total_items + costo_envio
  end
  
  def agregar_combo(combo_id, cantidad)
    item = carrito_items.find_by_combo_id(combo_id)
    
    if item
      item.agregar(cantidad)
    else
      item = carrito_items.build(combo_id: combo_id, cantidad: cantidad)      
    end
    
    item
  end
  
  def agregar_producto(producto_id, cantidad)
    item = carrito_items.find_by_producto_id(producto_id)
    
    if item
      item.agregar(cantidad)
    else
      item = carrito_items.build(producto_id: producto_id, cantidad: cantidad)
    end
    
    item
  end
  
end
