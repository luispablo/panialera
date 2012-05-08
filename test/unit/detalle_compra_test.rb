# == Schema Information
#
# Table name: detalles_compras
#
#  id          :integer         not null, primary key
#  compra_id   :integer
#  producto_id :integer
#  cantidad    :integer
#  precio      :float
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'test_helper'

class DetalleCompraTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
