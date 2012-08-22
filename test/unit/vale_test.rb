# == Schema Information
#
# Table name: vales
#
#  id                        :integer         not null, primary key
#  codigo                    :string(255)
#  nombre                    :string(255)
#  created_at                :datetime        not null
#  updated_at                :datetime        not null
#  porcentaje_descuento      :float
#  cantidad_usos_disponibles :integer
#

require 'test_helper'

class ValeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
