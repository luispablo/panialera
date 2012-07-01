# == Schema Information
#
# Table name: combo_detalles
#
#  id          :integer         not null, primary key
#  producto_id :integer
#  cantidad    :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  combo_id    :integer
#

class ComboDetalle < ActiveRecord::Base
  belongs_to :producto
  belongs_to :combo
  
  def precio_real
    unless cantidad.nil?
      producto.precio * cantidad
    else
        0
    end 
  end
end
