# == Schema Information
#
# Table name: cat_productos
#
#  id           :integer         not null, primary key
#  producto_id  :integer
#  categoria_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class CatProducto < ActiveRecord::Base
  belongs_to :producto
  belongs_to :categoria
  
  validates :producto_id, :uniqueness => { :scope => :categoria_id, :message => "La categoria puede vincularse una sola vez al producto" }
end
