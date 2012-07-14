class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :cargar_categorias, :cargar_usuario, :cargar_destacado
    
private
  def cargar_destacado
    destacados = Producto.where(destacado: true)
    @destacado = destacados[rand(destacados.size - 1)]
  end

  def cargar_carrito
    @carrito = carrito_actual
  end
  
  def cargar_categorias
    @categorias = Categoria.categorias_madre_publicadas.find_all { |c| !c.todos_productos.empty? }
  end

  def usuario_logueado?
    not session[:usuario_id].nil?
  end

  def cargar_usuario
    if session[:usuario_id]
      @usuario = Usuario.find(session[:usuario_id])
    end
  end

  def carrito_actual
    Carrito.find(session[:carrito_id])
  rescue ActiveRecord::RecordNotFound
    carrito = Carrito.create
    session[:carrito_id] = carrito.id
    carrito
  end
end
