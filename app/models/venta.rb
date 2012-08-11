# == Schema Information
#
# Table name: ventas
#
#  id                 :integer         not null, primary key
#  fecha              :date
#  usuario_id         :integer
#  domicilio_id       :integer
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  confirmada         :boolean
#  fecha_entrega      :date
#  hora_desde_entrega :time
#  hora_hasta_entrega :time
#  costo_envio        :float
#  comentarios        :string(255)
#  entregada          :boolean
#  codigo_vale        :string(255)
#  valor_descuento    :float
#

class Venta < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :domicilio
  
  has_many :venta_detalles, dependent: :destroy
  
  default_value_for :entregada, false

  attr_accessor :entrega

	def tiene_descuento?
		not (codigo_vale.nil? and (valor_descuento.nil? or valor_descuento == 0))
	end

  def self.crear_desde_carrito(carrito, usuario)
    venta = Venta.new
    
    venta.fecha = Date.today
    venta.usuario = usuario
    venta.domicilio = carrito.domicilio
    venta.confirmada = true
    venta.costo_envio = carrito.costo_envio
    venta.fecha_entrega = carrito.fecha_entrega
    venta.hora_desde_entrega = carrito.hora_desde_entrega
    venta.hora_hasta_entrega = carrito.hora_hasta_entrega
             
    if carrito.vale
    	venta.codigo_vale = carrito.vale.codigo
    	venta.valor_descuento = carrito.valor_descuento
    else
    	venta.valor_descuento = 0
    end
             
    venta.cargar_items_carrito(carrito)

    venta    
  end
  
  def hora_desde
    hora_desde_entrega.strftime('%H:%M')    
  end
  
  def hora_hasta
    hora_hasta_entrega.strftime('%H:%M')
  end
  
  def monto_total
    monto_total_lineas - valor_descuento + (costo_envio.nil? ? 0: costo_envio)
  end
  
  def monto_total_lineas
    venta_detalles.map{ |d| d.precio_total }.sum
  end
  
  def cargar_items_carrito(carrito)
    carrito.carrito_items.each do |i|
      venta_detalles << VentaDetalle.new(venta: self, producto: i.producto, cantidad: i.cantidad, precio: i.precio_unitario, combo: i.combo)
    end
  end

end
