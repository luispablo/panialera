﻿# == Schema Information
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
#  vale_id            :integer
#

class Carrito < ActiveRecord::Base
  has_many :carrito_items, dependent: :destroy, autosave: true
  
  validates_associated :carrito_items
  
  belongs_to :domicilio
  belongs_to :vale

	def vacio?
		carrito_items.empty? or carrito_items.to_a.sum { |item| item.cantidad } == 0
	end

	def cantidad_agregada(algo)
		carrito_items.find_all { |item| item.tiene_esto?(algo) }.sum { |item| item.cantidad }
	end
	
  def costo_envio
    if carrito_items.empty? or self.precio_total_items >= Parametro.monto_minimo_sin_envio
      0
    else
      Parametro.precio_envio
    end    
  end

	# Indica si alguna de las líneas no aplican a los vales de descuento
	def tiene_items_exentos_vale?
		not carrito_items.find_all { |item| not item.aplica_vale? }.empty?
	end
	
	# Esta es la papa, acá se calcula el descuento de los vales
	def valor_descuento
		carrito_items.to_a.sum { |item| item.valor_descuento }
	end

  def precio_total_items
    carrito_items.to_a.sum { |item| item.precio_total }
  end

  def precio_total
    precio_total_items - valor_descuento + costo_envio
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
