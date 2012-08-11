# == Schema Information
#
# Table name: vales
#
#  id                   :integer         not null, primary key
#  codigo               :string(255)
#  nombre               :string(255)
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  usuario_id           :integer
#  porcentaje_descuento :float
#  utilizado            :boolean
#

class Vale < ActiveRecord::Base
  belongs_to :usuario
end
