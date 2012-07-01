# == Schema Information
#
# Table name: combo_detalles
#
#  id          :integer         not null, primary key
#  producto_id :integer
#  cantidad    :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  combo_id    :integer
#

require 'test_helper'

class ComboDetalleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
