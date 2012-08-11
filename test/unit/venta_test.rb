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

require 'test_helper'

class VentaTest < ActiveSupport::TestCase

	test "crear venta para carrito para otro dia" do
		tomorrow = Date.today.next_day
		
		carrito = Carrito.new
		carrito.fecha_entrega = tomorrow
		
		venta = Venta.crear_desde_carrito(carrito, nil)
		
		assert_equal venta.fecha_entrega, tomorrow, "La venta debe ser para maniana"
	end
  # test "the truth" do
  #   assert true
  # end
end
