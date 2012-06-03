# == Schema Information
#
# Table name: ventas
#
#  id           :integer         not null, primary key
#  fecha        :date
#  usuario_id   :integer
#  domicilio_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class Venta < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :domicilio
  
  has_many :venta_detalles, dependent: :destroy
  
  def monto_total
    venta_detalles.map{ |d| d.precio_total }.sum
  end
end
