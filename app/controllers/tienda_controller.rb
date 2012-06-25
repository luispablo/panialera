class TiendaController < ApplicationController
  before_filter :cargar_carrito

  def busqueda
    @productos = Producto.buscar(params[:texto])
  end

  def confirmar
    @venta = Venta.crear_desde_carrito(@carrito, @usuario)
    @venta.save!
    
    @carrito.destroy
    
    VentaNotifier.confirmada(@venta).deliver
    
    mensaje = '¡Muchas gracias por tu compra! Recibirás un e-mail con el detalle de la misma.'
    
    if @usuario.ventas.size == 1
      mensaje << '<br/>IMPORTANTE: Como es la primera vez que comprás, estaremos llamándote por teléfono para confirmar tus datos.'
    end
    
    redirect_to tienda_url, notice: mensaje
  end
  
  def resumen
    @carrito.domicilio_id = params[:domicilio_id]
    
    entregas = Entrega.entregas_disponibles
      
    entregas.each do |e|
      if e.descripcion == params[:entrega]
        @carrito.fecha_entrega = e.fecha
        @carrito.hora_desde_entrega = e.desde
        @carrito.hora_hasta_entrega = e.hasta
        @carrito.save!
      end
    end      
  end

  def entrega
    @domicilio = Domicilio.find(params[:domicilio_id])
    @entregas = Entrega.entregas_disponibles
  end

  def seleccionar_domicilio
    if @carrito.carrito_items.empty?
      redirect_to tienda_url, notice: 'El carrito está vacío'
      return
    end
    
    unless usuario_logueado?
      redirect_to "/login_or_register"
      return
    end
    
    @domicilio = @usuario.domicilio_ultima_entrega
    @venta = Venta.new(:fecha => Date.today)    
  end

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
