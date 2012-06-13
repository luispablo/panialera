class TiendaController < ApplicationController
  before_filter :cargar_carrito

  def contacto
    if request.post?
      if params[:nombre].nil? or params[:nombre].empty?
        flash[:error] = 'Por favor ingrese su nombre'
        return
      elsif params[:como_llego].nil?
        flash[:error] = 'Por favor indique cómo nos conoció'
        return
      elsif params[:email].nil? or params[:email].empty?
        flash[:error] = 'Por favor ingrese su e-mail'
        return
      elsif params[:consulta].nil? or params[:consulta].empty?
        flash[:error] = 'Por favor indíquenos su consulta'
        return
      else
        TiendaNotifier.consulta(params[:nombre], "#{params[:como_llego]} #{params[:otros]}", params[:email], params[:consulta], params[:recibir_novedades]).deliver
        flash[:notice] = 'Su consulta ha sido enviada con éxito.'
      end
    end
  end
  
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
