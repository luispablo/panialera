# == Schema Information
#
# Table name: categorias
#
#  id           :integer         not null, primary key
#  codigo       :string(255)
#  nombre       :string(255)
#  descripcion  :string(255)
#  categoria_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class Categoria < ActiveRecord::Base
  belongs_to :categoria
  
  has_many :cat_productos
  has_many :categorias, :through => :cat_productos
  
end
