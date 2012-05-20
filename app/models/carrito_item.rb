# == Schema Information
#
# Table name: carrito_items
#
#  id          :integer         not null, primary key
#  producto_id :integer
#  carrito_id  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  cantidad    :float
#

class CarritoItem < ActiveRecord::Base
  belongs_to :producto
  belongs_to :carrito
  
  def precio_total
    producto.precio * cantidad
  end
end
