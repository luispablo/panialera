# == Schema Information
#
# Table name: entregas
#
#  id         :integer         not null, primary key
#  wday       :integer
#  desde      :time
#  hasta      :time
#  disponible :boolean
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'test_helper'

class EntregaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
