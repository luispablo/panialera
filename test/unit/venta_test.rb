# == Schema Information
#
# Table name: ventas
#
#  id           :integer         not null, primary key
#  fecha        :date
#  usuario_id   :integer
#  domicilio_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

require 'test_helper'

class VentaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end