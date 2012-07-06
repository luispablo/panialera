class TiendaController < ApplicationController
  before_filter :cargar_carrito

  def ofertas
    @combos = Combo.disponibles
    @productos = Producto.where(oferta: true)
  end

  def alcance
    
  end

  def busqueda
    @productos = Producto.buscar(params[:texto])
  end

  def confirmar
    @venta = Venta.crear_desde_carrito(@carrito, @usuario)
    @venta.save!
    
    @carrito.destroy
    
    unless @venta.domicilio.valido_delivery.nil?
      VentaNotifier.confirmada(@venta).deliver
    else
      VentaNotifier.pendiente_conf_domicilio(@venta).deliver
    end
    
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
    
    entregas_totales = Entrega.entregas_disponibles 
    excepciones = ExcepcionEntrega.aplicables
    entregas_disponibles = entregas_totales.find_all do |ed|
       excepciones.find_all { |ex| ex.incluye_entrega?(ed)  }.empty?
    end
    
    @entregas = Hash.new
    
    unless entregas_disponibles.nil? or entregas_disponibles.empty?
      entregas_disponibles.each do |e|
        @entregas[DIAS_SEMANA[e.wday]] = Array.new if @entregas[DIAS_SEMANA[e.wday]].nil?
        @entregas[DIAS_SEMANA[e.wday]] << e
      end
    end
    
  end

  def nuevo_dom
    @dom = Domicilio.new
    
    @dom.nombre = params[:nombre]
    @dom.calle = params[:calle]
    @dom.numero = params[:numero]
    @dom.piso = params[:piso]
    @dom.entre_calles = params[:entre_calles]
    @dom.codigo_postal = params[:codigo_postal]
    @dom.barrio_id = params[:barrio_id]
    @dom.usuario = @usuario
    @dom.valido_delivery = false
    @dom.save!
    
    redirect_to action: :entrega, domicilio_id: @dom.id
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
    combos = Combo.disponibles
    productos = Producto.where(oferta: true)
    
    @ofertas = (combos + productos).first(3)
  end
  
  def productos_categoria
    @categoria = Categoria.find_by_codigo(params[:codigo])    
    @opciones_orden = opciones_orden_categoria
    @orden = params[:orden] || 'nombre asc'
  end

  def detalle_producto
    @producto = Producto.find_by_codigo(params[:codigo])
  end

private
  def opciones_orden_categoria
    [
      ['Más baratos primero', 'precio asc'],
      ['Más caros primero', 'precio desc'],
      ['Desde la A a la Z', 'nombre asc'],
      ['Desde la Z a la A', 'nombre desc']
    ]    
  end
end
