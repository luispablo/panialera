# == Schema Information
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

require 'test_helper'

class CarritoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
