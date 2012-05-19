class ProductosController < AdminController
  # GET /productos
  # GET /productos.json
  def index
    @productos = Producto.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @productos }
    end
  end

  def categorias
    @producto = Producto.find(params[:id])
    @categorias = Categoria.all
  end

  # GET /productos/1
  # GET /productos/1.json
  def show
    @producto = Producto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @producto }
    end
  end

  # GET /productos/new
  # GET /productos/new.json
  def new
    @producto = Producto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @producto }
    end
  end

  # GET /productos/1/edit
  def edit
    @producto = Producto.find(params[:id])
  end

  # POST /productos
  # POST /productos.json
  def create
    @producto = Producto.new(params[:producto])

    respond_to do |format|
      if @producto.save
        format.html { redirect_to @producto, notice: 'Producto was successfully created.' }
        format.json { render json: @producto, status: :created, location: @producto }
      else
        format.html { render action: "new" }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /productos/1
  # PUT /productos/1.json
  def update
    @producto = Producto.find(params[:id])

    respond_to do |format|
      if @producto.update_attributes(params[:producto])
        format.html { redirect_to @producto, notice: 'Producto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /productos/1
  # DELETE /productos/1.json
  def destroy
    @producto = Producto.find(params[:id])
    @producto.destroy

    respond_to do |format|
      format.html { redirect_to productos_url }
      format.json { head :no_content }
    end
  end
  
  def agregar_categoria
    CatProducto.create(:producto_id => params[:producto_id], :categoria_id => params[:categoria_id])
    
    @categorias = Categoria.all
    @producto = Producto.find(params[:producto_id])
    
    render 'categorias'
  end
  
  def quitar_categoria
    @cat_producto = CatProducto.find(params[:id])
    @categorias = Categoria.all
    @producto = Producto.find(@cat_producto.producto_id)
    
    @cat_producto.destroy
    
    render 'categorias'
  end
end
