class VentaDetallesController < ApplicationController
  # GET /venta_detalles
  # GET /venta_detalles.json
  def index
    @venta_detalles = VentaDetalle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @venta_detalles }
    end
  end

  # GET /venta_detalles/1
  # GET /venta_detalles/1.json
  def show
    @venta_detalle = VentaDetalle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @venta_detalle }
    end
  end

  # GET /venta_detalles/new
  # GET /venta_detalles/new.json
  def new
    @venta_detalle = VentaDetalle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @venta_detalle }
    end
  end

  # GET /venta_detalles/1/edit
  def edit
    @venta_detalle = VentaDetalle.find(params[:id])
  end

  # POST /venta_detalles
  # POST /venta_detalles.json
  def create
    @venta_detalle = VentaDetalle.new(params[:venta_detalle])

    respond_to do |format|
      if @venta_detalle.save
        format.html { redirect_to @venta_detalle, notice: 'Venta detalle was successfully created.' }
        format.json { render json: @venta_detalle, status: :created, location: @venta_detalle }
      else
        format.html { render action: "new" }
        format.json { render json: @venta_detalle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /venta_detalles/1
  # PUT /venta_detalles/1.json
  def update
    @venta_detalle = VentaDetalle.find(params[:id])

    respond_to do |format|
      if @venta_detalle.update_attributes(params[:venta_detalle])
        format.html { redirect_to @venta_detalle, notice: 'Venta detalle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @venta_detalle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venta_detalles/1
  # DELETE /venta_detalles/1.json
  def destroy
    @venta_detalle = VentaDetalle.find(params[:id])
    @venta_detalle.destroy

    respond_to do |format|
      format.html { redirect_to venta_detalles_url }
      format.json { head :no_content }
    end
  end
end
