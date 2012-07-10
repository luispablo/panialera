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
  
  def pertenece_a?(categoria_id)
    unless categorias.nil? || categorias.empty?
      categorias.each { |c| return true if c.id == categoria_id }
    end
    
    false
  end
  
  def hay_stock?
    stock_disponible > 0
  end
  
  def stock_real
    stock_disponible + stock_comprometido
  end
  
  def stock_disponible
    stock.nil? ? 0 : stock
  end
  
  def stock_comprometido
    stock_comprometido = 0
    det_no_entregados = VentaDetalle.no_entregados

    unless det_no_entregados.nil?
      # Recorre todos los detalles de venta no entregados
      det_no_entregados.each do |d|
        unless d.producto.nil?
          # Si es un detalle con producto, y es ESTE producto, lo suma
          stock_comprometido += d.cantidad if d.producto.id == self.id
        else
          # En el caso de que sea un combo de productos...
          unless d.combo.nil? || d.combo.combo_detalles.nil?
            # Recorre los componentes del combo
            d.combo.combo_detalles.each do |cd|
              # Si el componente es ESTE producto, suma la cantidad por la cantidad del detalle
              stock_comprometido += (cd.cantidad * d.cantidad) if cd.producto_id == self.id
            end
          end
        end        
      end
    end
    
    stock_comprometido    
  end
  
  def quitar_stock(cantidad)
    if self.stock.nil?
      self.stock = 0
    else
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
  
  def descrip_corta
    descrip_corta = ""
    descrip_corta << "#{marca.nombre} " unless marca.nil?
    descrip_corta << "#{nombre} "
    descrip_corta << "#{talle}" unless talle.nil? or talle.empty?
    descrip_corta << "x#{referencia.split(' ')[0]}" unless referencia.nil? or referencia.empty?
    descrip_corta
  end
  
  def label_combos
    "[#{codigo}] #{marca.nombre} #{nombre} #{descripcion}  [#{talle}#{'x' unless referencia.nil? or referencia.empty?}#{referencia.split(' ')[0]}]"
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
  
  def self.search(search, categoria_id = nil)
    if search
      if categoria_id.nil? || categoria_id.empty?
        joins(:marca).where('marcas.nombre LIKE :search OR productos.nombre LIKE :search OR descripcion LIKE :search OR detalle LIKE :search OR codigo LIKE :search', search: "%#{search}%")
      else
        joins(:marca).joins(:cat_productos).where('cat_productos.categoria_id = :cat_id AND (marcas.nombre LIKE :search OR productos.nombre LIKE :search OR descripcion LIKE :search OR detalle LIKE :search OR codigo LIKE :search)', search: "%#{search}%", cat_id: categoria_id)
      end
    else
      if categoria_id.nil? || categoria_id.empty?
        scoped
      else
        joins(:cat_productos).where('cat_productos.categoria_id = :cat_id', cat_id: categoria_id)
      end
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
