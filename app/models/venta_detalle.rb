class VentaDetalle < ActiveRecord::Base
  belongs_to :venta
  belongs_to :producto
end
