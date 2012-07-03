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
#  talle       :string(255)
#  peso_bebe   :string(255)
#  edad_bebe   :string(255)
#  destacado   :boolean
#  oferta      :boolean
#  stock       :float
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
  
  def quitar_stock(cantidad)
    if self.stock.nil?
      self.stock = 0
    else
      logger.debug("stock: #{self.stock} - cantidad: #{cantidad}")
      self.stock -= cantidad
    end
  end 
  
  def agregar_stock(cantidad)
    if self.stock.nil?
      self.stock = cantidad
    else
      self.stock += cantidad
    end
  end
  
  def label_combos
    "[#{self.codigo}] #{self.nombre} #{self.descripcion} #{self.talle} [x#{self.referencia.split(' ')[0]}]"
  end
  
  def self.buscar(texto)
    Producto.joins(:marca).where(" productos.publicado = :publicado AND (productos.nombre like '%#{texto}%' or descripcion like '%#{texto}%' or detalle like '%#{texto}%' or marcas.nombre like '%#{texto}%') ", publicado: true)
  end
  
  def self.destacados
    Producto.where(destacado: true, publicado: true)
  end
  
  def cantidad_total_comprada
    compra_detalles.map { |d| d.cantidad.nil? ? 0 : d.cantidad }.sum
  end
  
  def monto_total_comprado
    compra_detalles.map { |d| d.precio_total }.sum
  end
  
  def self.search(search)
    if search
      where('nombre LIKE :search OR descripcion LIKE :search OR detalle LIKE :search OR codigo LIKE :search', search: "%#{search}%")
    else
      scoped
    end
  end

  def comparar(otro, orden)
    unless orden.nil?
      if orden == 'nombre asc'
        self.nombre <=> otro.nombre
      elsif orden == 'nombre desc'
        otro.nombre <=> self.nombre
      elsif orden == 'precio asc'
        self.precio <=> otro.precio
      elsif orden == 'precio desc'
        otro.precio <=> self.precio
      end
    else
      0
    end
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
