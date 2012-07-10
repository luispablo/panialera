# == Schema Information
#
# Table name: venta_detalles
#
#  id          :integer         not null, primary key
#  venta_id    :integer
#  producto_id :integer
#  cantidad    :float
#  precio      :float
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  combo_id    :integer
#

class VentaDetalle < ActiveRecord::Base
  belongs_to :venta
  belongs_to :producto
  belongs_to :combo

  after_save :actualizar_stock
  before_destroy :agregar_stock

  validate :alcanza_stock_producto

  def stock_disponible
    if producto.nil?
      combo.stock_disponible
    else
      producto.stock_disponible
    end
  end

  def alcanza_stock?
    logger.debug("cantidad: #{cantidad} vs. stock: #{stock_disponible}")
    cantidad <= stock_disponible
  end

  def self.no_entregados
    joins(:venta).where('ventas.entregada = :entregada', entregada: false)
  end

  def self.find_no_entregadas_by_combo(combo)
    joins(:venta).where("ventas.entregada = :no_entregada AND venta_detalles.combo_id = #{combo.id}", no_entregada: false)
  end
  
  def self.find_no_entregadas_by_producto(producto)
    joins(:venta).where("ventas.entregada = :no_entregada AND venta_detalles.producto_id = #{producto.id}", no_entregada: false)
  end
  
  def precio_unitario
    unless producto.nil?
      producto.precio
    else
      combo.precio
    end
  end
  
  def precio_total
    (precio * cantidad unless precio.nil? or cantidad.nil?) || 0
  end

private
  # Agregar stock a los productos al borrar este detalle  
  def agregar_stock
    if combo.nil?
      producto.agregar_stock cantidad
      producto.save!
    else
      combo.agregar_stock cantidad
      combo.save
    end
  end
  
  # Actualizar el stock al grabar este detalle
  def actualizar_stock
    delta = (cantidad_was.nil? ? 0 : cantidad_was) - cantidad
    logger.debug("delta #{delta} = cantidad_was #{cantidad_was} - cantidad #{cantidad}")
    modificar_stock delta
  end

  def modificar_stock(delta)
    if producto.nil?
      combo.modificar_stock delta
      combo.save
    else
      producto.agregar_stock delta
      producto.save
    end
  end

  def alcanza_stock_producto  
    errors[:base] << 'mensajes.ya_sin_stock' unless alcanza_stock?
  end  
  
end
