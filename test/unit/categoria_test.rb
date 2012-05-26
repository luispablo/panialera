# == Schema Information
#
# Table name: categorias
#
#  id           :integer         not null, primary key
#  codigo       :string(255)
#  nombre       :string(255)
#  descripcion  :string(255)
#  categoria_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  publicado    :boolean
#

require 'test_helper'

class CategoriaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
