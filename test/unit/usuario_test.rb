# == Schema Information
#
# Table name: usuarios
#
#  id              :integer         not null, primary key
#  nombre          :string(255)
#  apellido        :string(255)
#  sexo            :string(255)
#  tel_particular  :string(255)
#  tel_celular     :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  tel_laboral     :string(255)
#  password_digest :string(255)
#  administrador   :boolean
#  comentarios     :string(255)
#

require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
