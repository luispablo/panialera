# == Schema Information
#
# Table name: vales
#
#  id                        :integer         not null, primary key
#  codigo                    :string(255)
#  nombre                    :string(255)
#  created_at                :datetime        not null
#  updated_at                :datetime        not null
#  porcentaje_descuento      :float
#  cantidad_usos_disponibles :integer
#

# == Schema Information
#
# Table name: vales
#
#  id                        :integer         not null, primary key
#  codigo                    :string(255)
#  nombre                    :string(255)
#  created_at                :datetime        not null
#  updated_at                :datetime        not null
#  porcentaje_descuento      :float
#  cantidad_usos_disponibles :integer
#
class Vale < ActiveRecord::Base

	attr_accessor :valor_calculado
  belongs_to :usuario
  
  validates :codigo, presence: true, uniqueness: true
  validates :porcentaje_descuento, presence: true 
  
  def cancelar_uso
  	self.cantidad_usos_disponibles += 1 unless self.cantidad_usos_disponibles.nil?
  end
  
  def utilizar
  	self.cantidad_usos_disponibles-=1 unless cantidad_usos_disponibles.nil?
  end
  
  def se_puede_usar?
  	cantidad_usos_disponibles.nil? or cantidad_usos_disponibles > 0
  end
end

