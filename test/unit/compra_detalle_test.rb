# == Schema Information
#
# Table name: compra_detalles
#
#  id          :integer         not null, primary key
#  compra_id   :integer
#  producto_id :integer
#  cantidad    :float
#  precio      :float
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'test_helper'

class CompraDetalleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
