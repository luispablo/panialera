# == Schema Information
#
# Table name: domicilios
#
#  id             :integer         not null, primary key
#  nombre         :string(255)
#  calle          :string(255)
#  numero         :integer
#  piso           :string(255)
#  depto          :string(255)
#  entre_calles   :string(255)
#  codigo_postal  :string(255)
#  barrio_id      :integer
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  usuario_id     :integer
#  ultima_entrega :boolean
#

class Domicilio < ActiveRecord::Base
  belongs_to :barrio
  belongs_to :usuario
  
  def descripcion
    "#{calle} #{numero} #{piso} #{depto}"
  end
end
