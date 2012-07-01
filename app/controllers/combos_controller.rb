class CombosController < AdminController
  
  def agregar_detalle
    @combo = Combo.find(params[:combo_id])
    ComboDetalle.create(combo_id: @combo.id, producto_id: params[:producto_id])
    
    redirect_to @combo
  end
  
  def quitar_detalle
    @detalle = ComboDetalle.find(params[:id])
    @combo = @detalle.combo
    @detalle.destroy
    
    redirect_to @combo
  end
  
  # GET /combos
  # GET /combos.json
  def index
    @combos = Combo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @combos }
    end
  end

  # GET /combos/1
  # GET /combos/1.json
  def show
    @combo = Combo.find(params[:id])
    @productos = Producto.order(:codigo)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @combo }
    end
  end

  # GET /combos/new
  # GET /combos/new.json
  def new
    @combo = Combo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @combo }
    end
  end

  # GET /combos/1/edit
  def edit
    @combo = Combo.find(params[:id])
  end

  # POST /combos
  # POST /combos.json
  def create
    @combo = Combo.new(params[:combo])

    respond_to do |format|
      if @combo.save
        format.html { redirect_to @combo, notice: 'Combo was successfully created.' }
        format.json { render json: @combo, status: :created, location: @combo }
      else
        format.html { render action: "new" }
        format.json { render json: @combo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /combos/1
  # PUT /combos/1.json
  def update
    @combo = Combo.find(params[:id])

    respond_to do |format|
      if @combo.update_attributes(params[:combo])
        format.html { redirect_to @combo, notice: 'Combo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @combo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /combos/1
  # DELETE /combos/1.json
  def destroy
    @combo = Combo.find(params[:id])
    @combo.destroy

    respond_to do |format|
      format.html { redirect_to combos_url }
      format.json { head :no_content }
    end
  end
end
