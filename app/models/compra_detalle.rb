# == Schema Information
#
# Table name: compra_detalles
#
#  id          :integer         not null, primary key
#  compra_id   :integer
#  producto_id :integer
#  cantidad    :float
#  precio      :float
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class CompraDetalle < ActiveRecord::Base
  belongs_to :compra
  belongs_to :producto  

  after_save :actualizar_stock
    
  def precio_total
    (cantidad.nil? ? 0 : cantidad) * (precio.nil? ? 0 : precio)
  end
  
private
  def actualizar_stock
    producto.comprar cantidad
    producto.save!
  end
end
