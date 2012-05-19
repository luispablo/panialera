# == Schema Information
#
# Table name: productos
#
#  id          :integer         not null, primary key
#  codigo      :string(255)
#  nombre      :string(255)
#  descripcion :string(255)
#  detalle     :string(255)
#  precio      :float
#  referencia  :string(255)
#  disponible  :boolean
#  publicado   :boolean
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  marca_id    :integer
#  imagen      :string(255)
#

class Producto < ActiveRecord::Base
  belongs_to :marca
  
  has_many :cat_productos
  has_many :categorias, :through => :cat_productos

  mount_uploader :imagen, ImagenUploader
  
  validates :codigo, :nombre, :precio, :presence => { :message => "es un campo requerido." } 
end
