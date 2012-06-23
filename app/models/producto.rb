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
#  stock       :integer
#  talle       :string(255)
#  peso_bebe   :string(255)
#  edad_bebe   :string(255)
#  destacado   :boolean
#

class Producto < ActiveRecord::Base
  before_destroy :ensure_not_referenced_by_any_carrito_item
  
  belongs_to :marca
  
  has_many :cat_productos
  has_many :categorias, :through => :cat_productos
  has_many :carrito_items
  has_many :compra_detalles

  mount_uploader :imagen, ImagenUploader
  
  validates :codigo, :nombre, :precio, :presence => { :message => "es un campo requerido." }
  
  def self.destacados
    Producto.where(destacado: true)
  end
  
  def cantidad_total_comprada
    compra_detalles.map { |d| d.cantidad }.sum
  end
  
  def monto_total_comprado
    compra_detalles.map { |d| d.precio_total }.sum
  end
  
private
  def ensure_not_referenced_by_any_carrito_item
    if carrito_items.empty?
      return true
    else
      errors.add(:base, "Hay líneas de carrito que lo referencian")
      return false
    end
  end 
end
