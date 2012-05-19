# == Schema Information
#
# Table name: productos
#
#  id          :integer         not null, primary key
#  codigo      :string(255)
#  nombre      :string(255)
#  descripcion :string(255)
#  detalle     :string(255)
#  precio      :float
#  referencia  :string(255)
#  disponible  :boolean
#  publicado   :boolean
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  marca_id    :integer
#  imagen      :string(255)
#

require 'test_helper'

class ProductoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
