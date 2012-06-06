class ParametrosController < AdminController
  # GET /parametros
  # GET /parametros.json
  def index
    @parametros = Parametro.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parametros }
    end
  end

  # GET /parametros/1
  # GET /parametros/1.json
  def show
    @parametro = Parametro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parametro }
    end
  end

  # GET /parametros/new
  # GET /parametros/new.json
  def new
    @parametro = Parametro.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @parametro }
    end
  end

  # GET /parametros/1/edit
  def edit
    @parametro = Parametro.find(params[:id])
  end

  # POST /parametros
  # POST /parametros.json
  def create
    @parametro = Parametro.new(params[:parametro])

    respond_to do |format|
      if @parametro.save
        format.html { redirect_to @parametro, notice: 'Parametro was successfully created.' }
        format.json { render json: @parametro, status: :created, location: @parametro }
      else
        format.html { render action: "new" }
        format.json { render json: @parametro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /parametros/1
  # PUT /parametros/1.json
  def update
    @parametro = Parametro.find(params[:id])

    respond_to do |format|
      if @parametro.update_attributes(params[:parametro])
        format.html { redirect_to parametros_path, notice: 'Parametro was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @parametro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parametros/1
  # DELETE /parametros/1.json
  def destroy
    @parametro = Parametro.find(params[:id])
    @parametro.destroy

    respond_to do |format|
      format.html { redirect_to parametros_url }
      format.json { head :no_content }
    end
  end
end
