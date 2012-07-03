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

  after_save :agregar_stock
  before_destroy :quitar_stock
    
  def precio_total
    (cantidad.nil? ? 0 : cantidad) * (precio.nil? ? 0 : precio)
  end
  
private
  def quitar_stock
    producto.quitar_stock cantidad
    producto.save!
  end
  def agregar_stock
    producto.agregar_stock cantidad
    producto.save!
  end
end
