class ComboDetallesController < ApplicationController
  # GET /combo_detalles
  # GET /combo_detalles.json
  def index
    @combo_detalles = ComboDetalle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @combo_detalles }
    end
  end

  # GET /combo_detalles/1
  # GET /combo_detalles/1.json
  def show
    @combo_detalle = ComboDetalle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @combo_detalle }
    end
  end

  # GET /combo_detalles/new
  # GET /combo_detalles/new.json
  def new
    @combo_detalle = ComboDetalle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @combo_detalle }
    end
  end

  # GET /combo_detalles/1/edit
  def edit
    @combo_detalle = ComboDetalle.find(params[:id])
  end

  # POST /combo_detalles
  # POST /combo_detalles.json
  def create
    @combo_detalle = ComboDetalle.new(params[:combo_detalle])

    respond_to do |format|
      if @combo_detalle.save
        format.html { redirect_to @combo_detalle, notice: 'Combo detalle was successfully created.' }
        format.json { render json: @combo_detalle, status: :created, location: @combo_detalle }
      else
        format.html { render action: "new" }
        format.json { render json: @combo_detalle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /combo_detalles/1
  # PUT /combo_detalles/1.json
  def update
    @combo_detalle = ComboDetalle.find(params[:id])

    respond_to do |format|
      if @combo_detalle.update_attributes(params[:combo_detalle])
        format.html { redirect_to @combo_detalle, notice: 'Combo detalle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @combo_detalle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /combo_detalles/1
  # DELETE /combo_detalles/1.json
  def destroy
    @combo_detalle = ComboDetalle.find(params[:id])
    @combo_detalle.destroy

    respond_to do |format|
      format.html { redirect_to combo_detalles_url }
      format.json { head :no_content }
    end
  end
end
