class CompraDetallesController < ApplicationController
  # GET /compra_detalles
  # GET /compra_detalles.json
  def index
    @compra_detalles = CompraDetalle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @compra_detalles }
    end
  end

  # GET /compra_detalles/1
  # GET /compra_detalles/1.json
  def show
    @compra_detalle = CompraDetalle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @compra_detalle }
    end
  end

  # GET /compra_detalles/new
  # GET /compra_detalles/new.json
  def new
    @compra_detalle = CompraDetalle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @compra_detalle }
    end
  end

  # GET /compra_detalles/1/edit
  def edit
    @compra_detalle = CompraDetalle.find(params[:id])
  end

  # POST /compra_detalles
  # POST /compra_detalles.json
  def create
    @compra_detalle = CompraDetalle.new(params[:compra_detalle])

    respond_to do |format|
      if @compra_detalle.save
        format.html { redirect_to @compra_detalle, notice: 'Compra detalle was successfully created.' }
        format.json { render json: @compra_detalle, status: :created, location: @compra_detalle }
      else
        format.html { render action: "new" }
        format.json { render json: @compra_detalle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /compra_detalles/1
  # PUT /compra_detalles/1.json
  def update
    @compra_detalle = CompraDetalle.find(params[:id])

    respond_to do |format|
      if @compra_detalle.update_attributes(params[:compra_detalle])
        format.html { redirect_to @compra_detalle, notice: 'Compra detalle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @compra_detalle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compra_detalles/1
  # DELETE /compra_detalles/1.json
  def destroy
    @compra_detalle = CompraDetalle.find(params[:id])
    @compra_detalle.destroy

    respond_to do |format|
      format.html { redirect_to compra_detalles_url }
      format.json { head :no_content }
    end
  end
end
