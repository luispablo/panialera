class TiendaController < ApplicationController
  def index
    @productos = Producto.order(:nombre)
    @carrito = carrito_actual
  end
end
