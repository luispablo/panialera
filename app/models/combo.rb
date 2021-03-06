# == Schema Information
#
# Table name: combos
#
#  id          :integer         not null, primary key
#  codigo      :string(255)
#  precio      :float
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  imagen      :string(255)
#  nombre      :string(255)
#  publicado   :boolean
#  stock       :float
#  destacado   :boolean
#  aplica_vale :boolean
#

class Combo < ActiveRecord::Base
  has_many :combo_detalles, dependent: :destroy

  mount_uploader :imagen, ImagenUploader
    
	def self.buscar(texto)
		query = " combos.publicado = :publicado AND ( "
		query += " combos.nombre like '%#{texto}%' OR "
		query += " productos.nombre like '%#{texto}%' OR "
		query += " productos.descripcion like '%#{texto}%' OR "
		query += " productos.detalle like '%#{texto}%' OR "
		query += " marcas.nombre like '%#{texto}%' ) "
		
		combos = Combo.joins(combo_detalles: {producto: :marca}).where(query, publicado: true)
	end
	
	def self.destacados
		Combo.where(publicado: true, destacado: true)
	end
    
  def self.disponibles
    Combo.where(publicado: true)
  end

  def agregar_stock(cantidad)
    modificar_stock cantidad
  end
  
  def quitar_stock(cantidad)
    modificar_stock cantidad * (-1)
  end
  
  def modificar_stock(cantidad)
  	logger.debug("---- stock combo '#{detalle}': #{stock}")
  	
    if self.stock.nil?
      self.stock = 0
    else
      # Resta de su stock
			self.stock += cantidad
      # y además debe restar los stocks de los productos que lo componen.
      unless combo_detalles.nil?
        combo_detalles.each do |cd| 
          cd.agregar_stock cantidad          
        end
      end
    end
  end 
    
  def cuantos_se_pueden_armar
    if combo_detalles.nil?
      0
    else
      combo_detalles.map {|cd| cd.cuantos_se_pueden_armar }.min
    end
  end
  
  def hay_stock?
    stock_disponible > 0
  end
  
  def stock_real
    stock_disponible + stock_comprometido
  end
  
  def stock_disponible
    cantidad_armable = cuantos_se_pueden_armar 

		unless stock.nil?
		  if not cantidad_armable.nil? and stock <= cantidad_armable 
		    stock
		  else
		    cantidad_armable
		  end
		else
			0
		end
  end
  
  def stock_comprometido
    detalles = VentaDetalle.find_no_entregadas_by_combo(self)
    
    if detalles.nil? || detalles.empty?
      0
    else
      detalles.map {|d| d.cantidad }.sum
    end
  end
  
	# Realiza la comparación, sin tomar en cuenta el asc o desc.
	def comparar_campo(otro, orden)
		if orden.include?('nombre')
			if otro.kind_of?(Combo)
				self.detalle <=> otro.detalle
			elsif otro.kind_of?(Producto)
				self.detalle <=> otro.nombre
			end
		elsif orden.include?('precio')
			self.precio <=> otro.precio
		end
	end

	# Invoca la comparación real y multiplica por -1 luego si es desc.
  def comparar(otro, orden)
  	comparar_campo(otro, orden) * (orden.include?('asc')? 1 : -1)
  end
  
  # Indica si hay stock disponible de los productos
  # que componen el combo como para venderlo.
  def hay_stock_componentes?
    unless combo_detalles.nil?
      combo_detalles.each { |cd| return false unless cd.hay_stock? }
    end
    
    true
  end
  
  def precio_real
    combo_detalles.map {|cd| cd.precio_real }.sum
  end

  def contenido
    combo_detalles.map {|cd| "#{cd.cantidad} #{cd.producto.nombre}"}.join(' + ')
  end
  
  def detalle
    if nombre.nil? or nombre.empty?
      contenido
    else
      nombre
    end
  end
  
end
