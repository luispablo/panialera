# == Schema Information
#
# Table name: hijos
#
#  id               :integer         not null, primary key
#  nombre           :string(255)
#  apellido         :string(255)
#  fecha_nacimiento :date
#  sexo             :string(255)
#  usa_paniales     :boolean
#  usuario_id       :integer
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

require 'test_helper'

class HijoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
