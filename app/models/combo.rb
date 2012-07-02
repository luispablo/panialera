# == Schema Information
#
# Table name: combos
#
#  id         :integer         not null, primary key
#  codigo     :string(255)
#  precio     :float
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  imagen     :string(255)
#

class Combo < ActiveRecord::Base
  has_many :combo_detalles

  mount_uploader :imagen, ImagenUploader
    
  def precio_real
    combo_detalles.map {|cd| cd.precio_real }.sum
  end
  
  def detalle
    combo_detalles.map {|cd| cd.producto.nombre}.join(' + ')
  end
  
end
