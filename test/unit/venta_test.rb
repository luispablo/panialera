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
  # test "the truth" do
  #   assert true
  # end
end
