class TiendaController < ApplicationController

  before_filter :cargar_carrito
	before_filter :cargar_variables_orden, only: [:productos_categoria, :destacados, :ofertas]

  def detalle_combo
    @oferta = Combo.find(params[:combo_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to tienda_url, notice: 'La oferta que estás intentando ver no figura actualmente en nuestro catálogo'
  end
  
	def destacados
		@destacados = Producto.destacados(@orden)
		@destacados += Combo.destacados
		
		@destacados.sort { |a, b| a.comparar(b, @orden) }
	end

  def ofertas
		combos = Combo.disponibles
		productos = Producto.ofertas
		@ofertas = (combos + productos).sort { |a, b| a.comparar(b, @orden) }
  end

	def preguntas
	end
  
	def servicios
	end

	def nosotros
	
	end

  def alcance
    
  end

  def busqueda
    productos = Producto.buscar(params[:texto])
		combos = Combo.buscar(params[:texto])
		
		@items = combos + productos
  end

  def confirmar
    @venta = Venta.crear_desde_carrito(@carrito, @usuario)
    
    unless @venta.save
      flash[:error] = "No se puede completar la compra, ya que falta stock de algunos de los productos que elegiste."
      redirect_to @carrito
      return
    end
    
    @carrito.destroy
    
    unless @venta.domicilio.nil? or @venta.domicilio.valido_delivery.nil?
      VentaNotifier.confirmada(@venta).deliver
			VentaNotifier.venta_confirmada(@venta).deliver
    else
      VentaNotifier.pendiente_conf_domicilio(@venta).deliver
    end
    
    mensaje = '¡Muchas gracias por tu compra! Recibirás un e-mail con el detalle de la misma.'
    
    if @usuario.ventas.size == 1
      mensaje << '<br/>IMPORTANTE: Como es la primera vez que comprás, estaremos llamándote por teléfono para confirmar tus datos.'
    end
    
    unless @carrito.vale.nil?
		  @carrito.vale.utilizar
		  @carrito.vale.save
		end
    
    redirect_to tienda_url, notice: mensaje
  end
  
  def resumen
  	@mostrar_carrito = false

    entrega = Entrega.find(params[:entrega_id])

		unless params[:codigo_vale].nil?
			vale = Vale.where("codigo = '#{params[:codigo_vale].strip}'").first
			
			if vale
				if vale.se_puede_usar?
					@carrito.vale = vale
					flash[:error] = nil
				else
					flash[:error] = 'El vale que está intentando utilizar ya fue descontado de otra compra'
				end
			else
				flash[:error] = 'El código ingresado no corresponde a un vale de descuento habilitado'
			end
		end

    @carrito.domicilio_id = params[:domicilio_id]
    @carrito.fecha_entrega = Date.strptime(params[:fecha], '%Y%m%d')
    @carrito.hora_desde_entrega = entrega.desde
    @carrito.hora_hasta_entrega = entrega.hasta
    
    @carrito.save!
  end

  def entrega
  	@mostrar_carrito = false

    @domicilio = Domicilio.find(params[:domicilio_id])
    
    entregas_totales = Entrega.entregas_disponibles
    entregas_totales.each { |e| logger.debug("----------> [#{e.descripcion}]: #{e.cerrada?}") } 
    excepciones = ExcepcionEntrega.aplicables
    entregas_disponibles = entregas_totales.find_all do |ed|
       excepciones.find_all { |ex| ex.incluye_entrega?(ed)  }.empty?
    end
    
    @entregas = Hash.new
    
    unless entregas_disponibles.nil? or entregas_disponibles.empty?
      entregas_disponibles.each do |e|
        @entregas[e.fecha] = Array.new if @entregas[e.fecha].nil?
				@entregas[e.fecha] << e
      end
    end
    
  end

  def nuevo_dom
    @dom = Domicilio.new
    
    @dom.nombre = params[:nombre]
    @dom.calle = params[:calle]
    @dom.numero = params[:numero]
    @dom.piso = params[:piso]
		@dom.depto = params[:depto]    
    @dom.entre_calles = params[:entre_calles]
    @dom.codigo_postal = params[:codigo_postal]
    @dom.barrio_id = params[:barrio_id]
    @dom.usuario = @usuario
    @dom.save!
    
    redirect_to action: :entrega, domicilio_id: @dom.id
  end

  def seleccionar_domicilio
  	@mostrar_carrito = false
  
    if @carrito.vacio?
      redirect_to tienda_url, notice: 'El carrito está vacío'
      return
    end
    
    unless usuario_logueado?
      redirect_to "/login_or_register"
      return
    end
    
    unless @carrito.valid?
      flash[:error] = "No se puede completar la compra, ya que falta stock de algunos de los productos que elegiste."
      redirect_to @carrito
    end
    
    @domicilio = @usuario.domicilio_ultima_entrega
    @venta = Venta.new(:fecha => Date.today)    
  end

  def contacto
    if request.post?
      if params[:nombre].nil? or params[:nombre].empty?
        flash[:error] = 'Por favor ingrese su nombre'
        return
      elsif params[:email].nil? or params[:email].empty?
        flash[:error] = 'Por favor ingrese su e-mail'
        return
      elsif params[:consulta].nil? or params[:consulta].empty?
        flash[:error] = 'Por favor indíquenos su consulta'
        return
      else
        TiendaNotifier.consulta(params[:nombre], params[:email], params[:consulta], params[:recibir_novedades]).deliver
        flash[:notice] = 'Su consulta ha sido enviada con éxito.'
      end
    end
  end
  
  def index    
    combos = Combo.disponibles
    productos = Producto.ofertas
    
    @ofertas = (combos + productos).first(3)
  end
  
  def productos_categoria
    @categoria = Categoria.find_by_codigo(params[:codigo])    
    
    redirect_to tienda_url, notice: 'La categoría que estás intentando ver no figura actualmente en nuestro catálogo' unless @categoria
  end

  def detalle_producto
    @producto = Producto.find_by_codigo(params[:codigo])
    
    redirect_to tienda_url, notice: 'El producto que estás intentando ver no figura actualmente en nuestro catálogo' unless @producto
  end

private
	def ocultar_carrito
		@mostrar_carrito = false
	end
	
	def cargar_variables_orden
    @opciones_orden = opciones_orden_categoria
    @orden = params[:orden] || 'nombre asc'
	end
	
  def opciones_orden_categoria
    [
      ['Más baratos primero', 'precio asc'],
      ['Más caros primero', 'precio desc'],
      ['Desde la A a la Z', 'nombre asc'],
      ['Desde la Z a la A', 'nombre desc']
    ]    
  end
end
