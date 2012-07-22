class AdminController < ApplicationController
  before_filter :authorize

	before_filter :cargar_domicilios_a_validar, only: :index
  
  layout 'admin'

  def venta_entregada
    venta = Venta.find(params[:venta_id])
    venta.entregada = true
    venta.save!
    
    redirect_to controller: :admin, action: :index
  end
  
  def venta_cancelada
    venta = Venta.find(params[:venta_id])
    venta.destroy
    
    redirect_to controller: :admin, action: :index
  end

  def validar_domicilio
    @domicilio = Domicilio.find(params[:id])
    @domicilio.valido_delivery = true
    @domicilio.save

		cargar_domicilios_a_validar
    
    respond_to do |format|
      format.js
    end
  end
  
  def invalidar_domicilio
    @domicilio = Domicilio.find(params[:id])
    @domicilio.valido_delivery = false
    @domicilio.save
    
		cargar_domicilios_a_validar

		respond_to do |format|
			format.js
		end
  end

  def index
    @ventas_sin_conf = Venta.joins(:domicilio).where('domicilios.valido_delivery' => nil)
    @ventas_sin_entregar = Venta.where(entregada: false).order('fecha, hora_desde_entrega') - @ventas_sin_conf
  end
  
protected
	def cargar_domicilios_a_validar
    @domicilios = Domicilio.where('valido_delivery IS NULL')
	end
  def authorize
    unless @usuario and @usuario.administrador? 
      redirect_to tienda_url, notice: 'Debe ser administrador para poder ingresar a la administración.'
    end
  end
end
