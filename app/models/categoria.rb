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
#  publicado    :boolean
#

class Categoria < ActiveRecord::Base
  belongs_to :categoria
  
  has_many :cat_productos
  has_many :productos, :through => :cat_productos

  validates :codigo, uniqueness: true, presence: true
end
