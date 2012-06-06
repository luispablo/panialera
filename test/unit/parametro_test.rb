# == Schema Information
#
# Table name: parametros
#
#  id         :integer         not null, primary key
#  codigo     :string(255)
#  nombre     :string(255)
#  valor      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'test_helper'

class ParametroTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
