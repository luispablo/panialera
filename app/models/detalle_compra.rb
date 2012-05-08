# == Schema Information
#
# Table name: detalles_compras
#
#  id          :integer         not null, primary key
#  compra_id   :integer
#  producto_id :integer
#  cantidad    :integer
#  precio      :float
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class DetalleCompra < ActiveRecord::Base
  belongs_to :compra
  belongs_to :producto
end
