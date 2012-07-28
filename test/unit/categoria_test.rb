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
#  orden        :integer
#

require 'test_helper'

class CategoriaTest < ActiveSupport::TestCase

	test "mostrar solo subcategorias con productos" do
		hijas =	categorias(:madre1).hijas_publicadas
		
		assert_equal 1, hijas.size, "Debe tener 1 hija, la publicada con productos"
	end
	
end
