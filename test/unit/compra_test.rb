# == Schema Information
#
# Table name: compras
#
#  id           :integer         not null, primary key
#  fecha        :datetime
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  proveedor_id :integer
#

require 'test_helper'

class CompraTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
