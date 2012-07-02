# == Schema Information
#
# Table name: carrito_items
#
#  id          :integer         not null, primary key
#  producto_id :integer
#  carrito_id  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  cantidad    :float
#  combo_id    :integer
#

class CarritoItem < ActiveRecord::Base
  belongs_to :producto
  belongs_to :carrito
  belongs_to :combo
  
  def imagen_url(size)
    if self.producto.nil?
      self.combo.imagen_url(size)
    else
      self.producto.imagen_url(size)
    end
  end
  
  def imagen?
    (!self.producto.nil? && self.producto.imagen?) or (!self.combo.nil? && self.combo.imagen?)
  end
  
  def descripcion
    unless producto.nil?
      "#{producto.marca.nombre} #{producto.nombre} #{producto.descripcion}<br/>#{producto.referencia}".html_safe
    else
      combo.detalle
    end    
  end
  
  def desc_corta
    unless self.producto.nil?
      producto.nombre
    else
      combo.detalle
    end
  end
  
  def precio_unitario
    unless self.producto.nil?
      producto.precio
    else
      combo.precio
    end
  end
  
  def precio_total
    cantidad * (producto.nil? ? combo.precio : producto.precio)
  end
  
  def agregar(cantidad)
    self.cantidad += cantidad
  end
  
end
