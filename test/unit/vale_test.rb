# == Schema Information
#
# Table name: vales
#
#  id          :integer         not null, primary key
#  codigo      :string(255)
#  nombre      :string(255)
#  descripcion :string(255)
#  valor       :float
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  usuario_id  :integer
#

require 'test_helper'

class ValeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
