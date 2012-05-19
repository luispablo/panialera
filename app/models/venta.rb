class Venta < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :domicilio
end
