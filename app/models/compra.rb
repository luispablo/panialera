# == Schema Information
#
# Table name: compras
#
#  id           :integer         not null, primary key
#  fecha        :datetime
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  proveedor_id :integer
#

class Compra < ActiveRecord::Base
  belongs_to :proveedor
  
  has_many :compra_detalles, dependent: :destroy  
end
