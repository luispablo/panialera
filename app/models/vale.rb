# == Schema Information
#
# Table name: vales
#
#  id                   :integer         not null, primary key
#  codigo               :string(255)
#  nombre               :string(255)
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  porcentaje_descuento :float
#  utilizado            :boolean
#

class Vale < ActiveRecord::Base
	attr_accessor :valor_calculado
  belongs_to :usuario
  
  validates :codigo, presence: true, uniqueness: true
  validates :porcentaje_descuento, presence: true 
  
end
