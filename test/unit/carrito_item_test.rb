# == Schema Information
#
# Table name: carrito_items
#
#  id          :integer         not null, primary key
#  producto_id :integer
#  carrito_id  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'test_helper'

class CarritoItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
