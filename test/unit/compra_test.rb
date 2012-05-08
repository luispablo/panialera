# == Schema Information
#
# Table name: compras
#
#  id           :integer         not null, primary key
#  fecha        :datetime
#  usuario_id   :integer
#  domicilio_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

require 'test_helper'

class CompraTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
