class Venta < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :domicilio
  
  has_many :venta_detalles
end
