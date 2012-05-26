class AdminController < ApplicationController
  before_filter :authorize
  
  layout 'admin'

  def index
    
  end
  
protected
  def authorize
    unless session[:usuario_id] and Usuario.find(session[:usuario_id])
      redirect_to tienda_url, notice: 'Por favor log in'
    end
  end
end
