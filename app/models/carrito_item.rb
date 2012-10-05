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
  
  validate :alcanza_stock_producto
  
  def tiene_esto?(algo)
  	(algo.kind_of? Producto and self.producto_id == algo.id) or (algo.kind_of? Combo and self.combo_id == algo.id)
  end
  
  def stock_disponible
    if producto.nil?
      combo.stock_disponible
    else
      producto.stock_disponible
    end
  end
  
  def se_pueden_agregar_mas?
  	cantidad < stock_disponible
  end
  
  def alcanza_stock?
    cantidad <= stock_disponible
  end
  
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

	# Se fija si el producto o combo de esta línea aplica para
	# vales de descuento
	def aplica_vale?
		unless self.producto.nil?
			producto.aplica_vale
		else
			combo.aplica_vale
		end
	end
	
	# El precio total de la línea por el porcentaje de descuento
	# del vale del carrito.
	def valor_descuento
		precio_total * porcentaje_descuento
	end
	
	# Si el carrito tiene un vale, y el producto o combo aplica
	# para vales, devuelve el porcentaje de descuento del vale
	# del carrito, si no devuelve 0.
	def porcentaje_descuento
		if self.aplica_vale? and not self.carrito.vale.nil?
			self.carrito.vale.porcentaje_descuento / 100
		else
			0
		end
	end
	
  def precio_total
    cantidad * precio_unitario
  end
  
  def agregar(cantidad)
    self.cantidad += cantidad
  end

private
  def alcanza_stock_producto    
    unless alcanza_stock?
      errors.add(:cantidad, 'mensajes.ya_sin_stock')
    end
  end  
end
