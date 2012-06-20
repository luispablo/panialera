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
#

class Venta < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :domicilio
  
  has_many :venta_detalles, dependent: :destroy
  
  attr_accessor :entrega
  
  def monto_total
    monto_total_lineas + (costo_envio.nil? ? 0: costo_envio)
  end
  
  def monto_total_lineas
    venta_detalles.map{ |d| d.precio_total }.sum
  end
  
  def cargar_items_carrito(carrito)
    carrito.carrito_items.each do |i|
      VentaDetalle.create(venta: self, producto: i.producto, cantidad: i.cantidad, precio: i.producto.precio)
    end
  end
end
