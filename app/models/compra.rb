# == Schema Information
#
# Table name: compras
#
#  id           :integer         not null, primary key
#  fecha        :datetime
#  usuario_id   :integer
#  domicilio_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class Compra < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :domicilio
  
  has_many :compra_detalles, dependent: :destroy
end
