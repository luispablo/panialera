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
#  nombre     :string(255)
#  publicado  :boolean
#

class Combo < ActiveRecord::Base
  has_many :combo_detalles

  mount_uploader :imagen, ImagenUploader
    
  def self.disponibles
    Combo.where(publicado: true)
  end
  
  def precio_real
    combo_detalles.map {|cd| cd.precio_real }.sum
  end

  def contenido
    combo_detalles.map {|cd| "#{cd.cantidad} #{cd.producto.nombre}"}.join(' + ')
  end
  
  def detalle
    nombre || contenido
  end
  
end
