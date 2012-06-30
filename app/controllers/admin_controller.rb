class AdminController < ApplicationController
  before_filter :authorize
  
  layout 'admin'

  def validar_domicilio
    domicilio = Domicilio.find(params[:id])
    domicilio.validar_para_delivery
    
    redirect_to controller: :admin, action: :index
  end
  
  def invalidar_domicilio
    domicilio = Domicilio.find(params[:id])
    domicilio.invalidar_para_delivery
    
    redirect_to controller: :admin, action: :index
  end

  def index
    @domicilios = Domicilio.where(valido_delivery: nil)
    @ventas_sin_conf = Venta.joins(:domicilio).where('domicilios.valido_delivery' => nil)
  end
  
protected
  def authorize
    unless session[:usuario_id] and Usuario.find(session[:usuario_id])
      redirect_to tienda_url, notice: 'Por favor log in'
    end
  end
end
