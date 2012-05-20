class ApplicationController < ActionController::Base
  protect_from_forgery
  
private
  def carrito_actual
    Carrito.find(session[:carrito_id])
  rescue ActiveRecord::RecordNotFound
    carrito = Carrito.create
    session[:carrito_id] = carrito.id
    carrito
  end
end
