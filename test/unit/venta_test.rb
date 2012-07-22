# == Schema Information
#
# Table name: ventas
#
#  id                 :integer         not null, primary key
#  fecha              :date
#  usuario_id         :integer
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  confirmada         :boolean
#  fecha_entrega      :date
#  hora_desde_entrega :time
#  hora_hasta_entrega :time
#  costo_envio        :float
#  comentarios        :string(255)
#  entregada          :boolean
#  dom_calle          :string(255)
#  dom_numero         :integer
#  dom_piso           :string(255)
#  dom_depto          :string(255)
#  dom_entre_calles   :string(255)
#  barrio_id          :integer
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
