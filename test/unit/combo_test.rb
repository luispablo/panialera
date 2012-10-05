# == Schema Information
#
# Table name: combos
#
#  id          :integer         not null, primary key
#  codigo      :string(255)
#  precio      :float
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  imagen      :string(255)
#  nombre      :string(255)
#  publicado   :boolean
#  stock       :float
#  destacado   :boolean
#  aplica_vale :boolean
#

require 'test_helper'

class ComboTest < ActiveSupport::TestCase

	test "quitar stock" do
		combo = Combo.new
		combo.stock = 5
		combo.modificar_stock -1
		
		assert_equal combo.stock, 4, "Se quito un item del stock"
	end
  # test "the truth" do
  #   assert true
  # end
end
