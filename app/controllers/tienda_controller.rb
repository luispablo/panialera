class TiendaController < ApplicationController
  before_filter :cargar_carrito
  
  def index
    @productos_destacados = Producto.destacados
  end
  
  def productos_categoria
    @categoria = Categoria.find_by_codigo(params[:codigo])
  end

  def detalle_producto
    @producto = Producto.find_by_codigo(params[:codigo])
  end
  
end
