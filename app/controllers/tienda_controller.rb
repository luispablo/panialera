class TiendaController < ApplicationController
  def index
    @productos_destacados = Producto.destacados
    @carrito = carrito_actual
  end
end
