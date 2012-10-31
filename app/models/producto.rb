# == Schema Information
#
# Table name: productos
#
#  id          :integer         not null, primary key
#  codigo      :string(255)
#  nombre      :string(255)
#  descripcion :string(255)
#  detalle     :text(255)
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
#  aplica_vale :boolean
#

class Producto < ActiveRecord::Base
  before_destroy :ensure_not_referenced
  
  belongs_to :marca
  
  has_many :cat_productos, dependent: :destroy
  has_many :categorias, :through => :cat_productos
  has_many :carrito_items, dependent: :destroy
  has_many :compra_detalles
  has_many :venta_detalles

  mount_uploader :imagen, ImagenUploader
  
  validates :codigo, :nombre, :precio, :presence => { :message => "es un campo requerido." }
  validates :codigo, uniqueness:  { message: 'El código que intentás utilizar ya está en uso.' }
  
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
    "#{marca.nombre} #{nombre} #{descripcion}  [#{talle}#{'x' unless referencia.nil? or referencia.empty?}#{referencia.split(' ')[0]}] [#{codigo}]"
  end
  
  def self.buscar(texto)
    Producto.joins(:marca).where(" productos.publicado = :publicado AND (productos.nombre like '%#{texto}%' or descripcion like '%#{texto}%' or detalle like '%#{texto}%' or marcas.nombre like '%#{texto}%') ", publicado: true)
  end
  
  def self.ofertas
  	Producto.where(oferta: true, publicado: true)
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
  
	# Busca los productos destacados, por orden
	def self.destacados(orden = nil)
		return Producto.where(destacado: true, publicado: true).sort { |a, b| a.comparar(b, orden) }
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

	# Realiza la comparación, sin tomar en cuenta el asc o desc.
	def comparar_campo(otro, orden)
		if orden.nil? or orden.include?('nombre')
			if otro.kind_of?(Producto)
				self.nombre <=> otro.nombre
			elsif otro.kind_of?(Combo)
				self.nombre <=> otro.detalle
			end
		elsif orden.include?('precio')
			self.precio <=> otro.precio
		end
	end

	# Invoca la comparación real y multiplica por -1 luego si es desc.
  def comparar(otro, orden)
  	comparar_campo(otro, orden) * ((orden.nil? or orden.include?('asc'))? 1 : -1)
  end

private
  def ensure_not_referenced
    valido = true
        
    unless compra_detalles.empty?
      errors.add(:base, "Hay compras que referencian a este producto")
      valido = false
    end    
    
    unless venta_detalles.empty?
      errors.add(:base, "Hay ventas que referencian a este producto")
      valido = false
    end
    
    valido
  end 
end
