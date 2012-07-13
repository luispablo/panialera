class AdminController < ApplicationController
  before_filter :authorize
  
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
    
    @domicilios = Domicilio.where('valido_delivery <> ? or valido_delivery IS NULL', true)
    
    respond_to do |format|
      format.js
    end
  end
  
  def invalidar_domicilio
    domicilio = Domicilio.find(params[:id])
    domicilio.valido_delivery = false
    domicilio.save
    
    redirect_to controller: :admin, action: :index
  end

  def index
    @domicilios = Domicilio.where('valido_delivery <> ? or valido_delivery IS NULL', true)
    @ventas_sin_conf = Venta.joins(:domicilio).where('domicilios.valido_delivery' => nil)
    @ventas_sin_entregar = Venta.where(entregada: false).order('fecha, hora_desde_entrega')
  end
  
protected
  def authorize
    unless session[:usuario_id] and Usuario.find(session[:usuario_id])
      redirect_to tienda_url, notice: 'Por favor log in'
    end
  end
end
