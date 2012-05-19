# == Schema Information
#
# Table name: cat_productos
#
#  id           :integer         not null, primary key
#  producto_id  :integer
#  categoria_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

require 'test_helper'

class CatProductosTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
