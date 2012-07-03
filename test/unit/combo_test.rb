# == Schema Information
#
# Table name: combos
#
#  id         :integer         not null, primary key
#  codigo     :string(255)
#  precio     :float
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  imagen     :string(255)
#  nombre     :string(255)
#

require 'test_helper'

class ComboTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
