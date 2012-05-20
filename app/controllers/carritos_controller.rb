class CarritosController < ApplicationController
  # GET /carritos
  # GET /carritos.json
  def index
    @carritos = Carrito.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carritos }
    end
  end

  # GET /carritos/1
  # GET /carritos/1.json
  def show
    @carrito = Carrito.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @carrito }
    end
  end

  # GET /carritos/new
  # GET /carritos/new.json
  def new
    @carrito = Carrito.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @carrito }
    end
  end

  # GET /carritos/1/edit
  def edit
    @carrito = Carrito.find(params[:id])
  end

  # POST /carritos
  # POST /carritos.json
  def create
    @carrito = Carrito.new(params[:carrito])

    respond_to do |format|
      if @carrito.save
        format.html { redirect_to @carrito, notice: 'Carrito was successfully created.' }
        format.json { render json: @carrito, status: :created, location: @carrito }
      else
        format.html { render action: "new" }
        format.json { render json: @carrito.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carritos/1
  # PUT /carritos/1.json
  def update
    @carrito = Carrito.find(params[:id])

    respond_to do |format|
      if @carrito.update_attributes(params[:carrito])
        format.html { redirect_to @carrito, notice: 'Carrito was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @carrito.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carritos/1
  # DELETE /carritos/1.json
  def destroy
    @carrito = Carrito.find(params[:id])
    @carrito.destroy

    respond_to do |format|
      format.html { redirect_to carritos_url }
      format.json { head :no_content }
    end
  end
end
