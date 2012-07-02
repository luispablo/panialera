class ExcepcionEntregasController < AdminController
  # GET /excepcion_entregas
  # GET /excepcion_entregas.json
  def index
    @excepcion_entregas = ExcepcionEntrega.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @excepcion_entregas }
    end
  end

  # GET /excepcion_entregas/1
  # GET /excepcion_entregas/1.json
  def show
    @excepcion_entrega = ExcepcionEntrega.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @excepcion_entrega }
    end
  end

  # GET /excepcion_entregas/new
  # GET /excepcion_entregas/new.json
  def new
    @excepcion_entrega = ExcepcionEntrega.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @excepcion_entrega }
    end
  end

  # GET /excepcion_entregas/1/edit
  def edit
    @excepcion_entrega = ExcepcionEntrega.find(params[:id])
  end

  # POST /excepcion_entregas
  # POST /excepcion_entregas.json
  def create
    @excepcion_entrega = ExcepcionEntrega.new(params[:excepcion_entrega])

    respond_to do |format|
      if @excepcion_entrega.save
        format.html { redirect_to @excepcion_entrega, notice: 'Excepcion entrega was successfully created.' }
        format.json { render json: @excepcion_entrega, status: :created, location: @excepcion_entrega }
      else
        format.html { render action: "new" }
        format.json { render json: @excepcion_entrega.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /excepcion_entregas/1
  # PUT /excepcion_entregas/1.json
  def update
    @excepcion_entrega = ExcepcionEntrega.find(params[:id])

    respond_to do |format|
      if @excepcion_entrega.update_attributes(params[:excepcion_entrega])
        format.html { redirect_to @excepcion_entrega, notice: 'Excepcion entrega was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @excepcion_entrega.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /excepcion_entregas/1
  # DELETE /excepcion_entregas/1.json
  def destroy
    @excepcion_entrega = ExcepcionEntrega.find(params[:id])
    @excepcion_entrega.destroy

    respond_to do |format|
      format.html { redirect_to excepcion_entregas_url }
      format.json { head :no_content }
    end
  end
end
