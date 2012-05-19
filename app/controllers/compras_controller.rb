class ComprasController < AdminController
  # GET /compras
  # GET /compras.json
  def index
    @compras = Compra.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @compras }
    end
  end

  # GET /compras/1
  # GET /compras/1.json
  def show
    @compra = Compra.find(params[:id])
    @productos = Producto.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @compra }
    end
  end

  # GET /compras/new
  # GET /compras/new.json
  def new
    @compra = Compra.new(:fecha => Date.today)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @compra }
    end
  end

  # GET /compras/1/edit
  def edit
    @compra = Compra.find(params[:id])
  end

  # POST /compras
  # POST /compras.json
  def create
    @compra = Compra.new(params[:compra])

    respond_to do |format|
      if @compra.save
        format.html { redirect_to @compra, notice: 'Compra was successfully created.' }
        format.json { render json: @compra, status: :created, location: @compra }
      else
        format.html { render action: "new" }
        format.json { render json: @compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /compras/1
  # PUT /compras/1.json
  def update
    @compra = Compra.find(params[:id])

    respond_to do |format|
      if @compra.update_attributes(params[:compra])
        format.html { redirect_to @compra, notice: 'Compra was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compras/1
  # DELETE /compras/1.json
  def destroy
    @compra = Compra.find(params[:id])
    @compra.destroy

    respond_to do |format|
      format.html { redirect_to compras_url }
      format.json { head :no_content }
    end
  end
  
  def agregar_detalle
    @compra = Compra.find(params[:compra_id])
    @productos = Producto.all
    CompraDetalle.create(:compra_id => @compra.id, :producto_id => params[:producto_id])
    
    render 'show'
  end
  
  def quitar_detalle
    @detalle = CompraDetalle.find(params[:id])
    @compra = @detalle.compra
    @productos = Producto.all
    @detalle.destroy
    
    render 'show'
  end
end
