# == Schema Information
#
# Table name: productos
#
#  id          :integer         not null, primary key
#  codigo      :string(255)
#  nombre      :string(255)
#  descripcion :string(255)
#  detalle     :text(255)
#  precio      :float
#  referencia  :string(255)
#  disponible  :boolean
#  publicado   :boolean
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  marca_id    :integer
#  imagen      :string(255)
#  talle       :string(255)
#  peso_bebe   :string(255)
#  edad_bebe   :string(255)
#  destacado   :boolean
#  oferta      :boolean
#  stock       :float
#  aplica_vale :boolean
#

require 'test_helper'

class ProductoTest < ActiveSupport::TestCase

	test "deben poder compararse con combos" do
		coleccion = Producto.all + Combo.all
		coleccion = coleccion.sort { |a, b| a.comparar(b, 'nombre asc') }
		
		assert_equal coleccion.first, combos(:uno), "Ordenar todo por nombre deja primero un combo"
	end

	test "deben ordenarse por defecto por nombre" do
		primero = Producto.all.sort { |a, b| a.comparar(b, nil) }.first
		
		assert_equal primero, productos(:uno), "Por defecto el primero es uno"
	end

	test "deben poder ordenarse por precio" do
		primero = Producto.all.sort { |a, b| a.comparar(b, 'precio desc') }.first
		
		assert_equal primero, productos(:dos), "El mas caro es el segundo producto"
	end

	test "deben poder ordenarse por nombre" do
		primero = Producto.all.sort { |a, b| a.comparar(b, 'nombre asc') }.first
		
		assert_equal primero, productos(:uno), "Ordenamiento asc"
		
		primero = Producto.all.sort { |a, b| a.comparar(b, 'nombre desc') }.first
		
		assert_equal primero, productos(:tres), "Ordenamiento desc"
	end

end
