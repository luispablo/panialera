# == Schema Information
#
# Table name: venta_detalles
#
#  id          :integer         not null, primary key
#  venta_id    :integer
#  producto_id :integer
#  cantidad    :float
#  precio      :float
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class VentaDetalle < ActiveRecord::Base
  belongs_to :venta
  belongs_to :producto
end