class VentasController < ApplicationController
  before_filter :cargar_carrito
  before_filter :cargar_referencias, :only =>['new', 'edit']
  before_filter :cargar_productos, :only => ['show', 'agregar_detalle', 'quitar_detalle']

  def confirmar
    @venta = Venta.find(params[:id])    
    @venta.cargar_items_carrito(@carrito)
    @venta.confirmada = true
    @venta.save
    
    @carrito.destroy
  end
  
  # GET /ventas
  # GET /ventas.json
  def index
    @ventas = Venta.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ventas }
    end
  end

  # GET /ventas/1
  # GET /ventas/1.json
  def show
    @venta = Venta.find(params[:id])

    respond_to do |format|
      format.html do
        if @venta.fecha_entrega.nil? 
          @entregas = Entrega.entregas_disponibles
          render 'entrega'
        end
      end# show.html.erb
      format.json { render json: @venta }
    end
  end

  def cambiar_domicilio_entrega
    @anterior = Domicilio.find(params[:from])
    @domicilio = Domicilio.find(params[:to])
    
    @anterior.ultima_entrega = false
    @anterior.save
    
    @domicilio.ultima_entrega = true
    @domicilio.save
    
    render 'new'
  end

  # GET /ventas/new
  # GET /ventas/new.json
  def new
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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @venta }
    end
  end

  # GET /ventas/1/edit
  def edit
    @venta = Venta.find(params[:id])
  end

  # POST /ventas
  # POST /ventas.json
  def create
    @venta = Venta.new(params[:venta])

    respond_to do |format|
      if @venta.save
        format.html { redirect_to @venta, notice: 'Venta was successfully created.' }
        format.json { render json: @venta, status: :created, location: @venta }
      else
        format.html { render action: "new" }
        format.json { render json: @venta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ventas/1
  # PUT /ventas/1.json
  def update
    @venta = Venta.find(params[:id])

    unless params[:venta][:entrega].nil?
      entregas = Entrega.entregas_disponibles
      
      entregas.each do |e|
        if e.descripcion == params[:venta][:entrega]
          @venta.fecha_entrega = e.fecha
          @venta.hora_desde_entrega = e.desde
          @venta.hora_hasta_entrega = e.hasta
          @venta.save
        end
      end
      
      redirect_to @venta
      return
    end

    respond_to do |format|
      if @venta.update_attributes(params[:venta])
        format.html { redirect_to @venta, notice: 'Venta was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @venta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ventas/1
  # DELETE /ventas/1.json
  def destroy
    @venta = Venta.find(params[:id])
    @venta.destroy

    respond_to do |format|
      format.html { redirect_to ventas_url }
      format.json { head :no_content }
    end
  end
  
  def agregar_detalle
    @venta = Venta.find(params[:venta_id])
    VentaDetalle.create(:venta_id => @venta.id, :producto_id => params[:producto_id])
    
    render 'show'
  end
  
  def quitar_detalle
    @detalle = VentaDetalle.find(params[:id])
    @venta = @detalle.venta
    @detalle.destroy
    
    render 'show'
  end
  
private
  def cargar_productos
    @productos = Producto.all
  end
  
  def cargar_referencias
    @usuarios = Usuario.all
    @domicilios = Domicilio.all
  end
end
