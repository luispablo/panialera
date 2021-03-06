class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :cargar_categorias, :cargar_usuario, :cargar_destacado, :cargar_variables
    
private
	def cargar_variables
		@importe_minimo = Parametro.monto_minimo_sin_envio
		@costo_envio = Parametro.precio_envio	
	end

  def cargar_destacado
    destacados = Producto.destacados
		destacados += Combo.destacados
		
    @destacado = destacados[rand(destacados.size)]
  end

  def cargar_carrito
    @carrito = carrito_actual
    @mostrar_carrito = true
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
