class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :cargar_categorias
  
private
  def cargar_categorias
    @categorias = Categoria.where(publicado: true)
  end
  def carrito_actual
    Carrito.find(session[:carrito_id])
  rescue ActiveRecord::RecordNotFound
    carrito = Carrito.create
    session[:carrito_id] = carrito.id
    carrito
  end
end
