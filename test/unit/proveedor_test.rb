# == Schema Information
#
# Table name: proveedores
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  direccion  :string(255)
#  telefono   :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'test_helper'

class ProveedorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
