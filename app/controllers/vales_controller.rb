class ValesController < ApplicationController
	layout 'admin'
	
  # GET /vales
  # GET /vales.json
  def index
    @vales = Vale.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vales }
    end
  end

  # GET /vales/1
  # GET /vales/1.json
  def show
    @vale = Vale.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vale }
    end
  end

  # GET /vales/new
  # GET /vales/new.json
  def new
    @vale = Vale.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vale }
    end
  end

  # GET /vales/1/edit
  def edit
    @vale = Vale.find(params[:id])
  end

  # POST /vales
  # POST /vales.json
  def create
    @vale = Vale.new(params[:vale])

    respond_to do |format|
      if @vale.save
        format.html { redirect_to @vale, notice: 'Vale was successfully created.' }
        format.json { render json: @vale, status: :created, location: @vale }
      else
        format.html { render action: "new" }
        format.json { render json: @vale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vales/1
  # PUT /vales/1.json
  def update
    @vale = Vale.find(params[:id])

    respond_to do |format|
      if @vale.update_attributes(params[:vale])
        format.html { redirect_to @vale, notice: 'Vale was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vales/1
  # DELETE /vales/1.json
  def destroy
    @vale = Vale.find(params[:id])
    @vale.destroy

    respond_to do |format|
      format.html { redirect_to vales_url }
      format.json { head :no_content }
    end
  end
end
