class CarritoItemsController < ApplicationController
  # GET /carrito_items
  # GET /carrito_items.json
  def index
    @carrito_items = CarritoItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carrito_items }
    end
  end

  # GET /carrito_items/1
  # GET /carrito_items/1.json
  def show
    @carrito_item = CarritoItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @carrito_item }
    end
  end

  # GET /carrito_items/new
  # GET /carrito_items/new.json
  def new
    @carrito_item = CarritoItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @carrito_item }
    end
  end

  # GET /carrito_items/1/edit
  def edit
    @carrito_item = CarritoItem.find(params[:id])
  end

  # POST /carrito_items
  # POST /carrito_items.json
  def create
    @carrito = carrito_actual
    producto = Producto.find(params[:producto_id])
    @carrito_item = @carrito.agregar_producto(producto.id) 

    respond_to do |format|
      if @carrito_item.save
        format.html { redirect_to tienda_url }
        format.js { @item_actual = @carrito_item }
        format.json { render json: @carrito_item, status: :created, location: @carrito_item }
      else
        format.html { render action: "new" }
        format.json { render json: @carrito_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carrito_items/1
  # PUT /carrito_items/1.json
  def update
    @carrito_item = CarritoItem.find(params[:id])

    respond_to do |format|
      if @carrito_item.update_attributes(params[:carrito_item])
        format.html { redirect_to @carrito_item, notice: 'Carrito item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @carrito_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carrito_items/1
  # DELETE /carrito_items/1.json
  def destroy
    @carrito_item = CarritoItem.find(params[:id])
    @carrito_item.destroy

    respond_to do |format|
      format.html { redirect_to carrito_items_url }
      format.json { head :no_content }
    end
  end
end
