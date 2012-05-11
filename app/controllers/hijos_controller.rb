class HijosController < AdminController
  # GET /hijos
  # GET /hijos.json
  def index
    @hijos = Hijo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hijos }
    end
  end

  # GET /hijos/1
  # GET /hijos/1.json
  def show
    @hijo = Hijo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hijo }
    end
  end

  # GET /hijos/new
  # GET /hijos/new.json
  def new
    @hijo = Hijo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hijo }
    end
  end

  # GET /hijos/1/edit
  def edit
    @hijo = Hijo.find(params[:id])
  end

  # POST /hijos
  # POST /hijos.json
  def create
    @hijo = Hijo.new(params[:hijo])

    respond_to do |format|
      if @hijo.save
        format.html { redirect_to @hijo, notice: 'Hijo was successfully created.' }
        format.json { render json: @hijo, status: :created, location: @hijo }
      else
        format.html { render action: "new" }
        format.json { render json: @hijo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hijos/1
  # PUT /hijos/1.json
  def update
    @hijo = Hijo.find(params[:id])

    respond_to do |format|
      if @hijo.update_attributes(params[:hijo])
        format.html { redirect_to @hijo, notice: 'Hijo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hijo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hijos/1
  # DELETE /hijos/1.json
  def destroy
    @hijo = Hijo.find(params[:id])
    @hijo.destroy

    respond_to do |format|
      format.html { redirect_to hijos_url }
      format.json { head :no_content }
    end
  end
end
