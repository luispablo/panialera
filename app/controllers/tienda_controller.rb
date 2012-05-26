class TiendaController < ApplicationController
  before_filter :cargar_carrito
  
  def index
    @productos_destacados = Producto.destacados
  end
  
  def productos_categoria
    @categoria = Categoria.find_by_codigo(params[:codigo])
  end
  
private
  def cargar_carrito
    @carrito = carrito_actual
  end
end
