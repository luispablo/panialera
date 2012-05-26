class SessionsController < ApplicationController
  def new
  end

  def create
    usuario = Usuario.find_by_email(params[:email])
    
    if usuario and usuario.authenticate(params[:password])
      session[:usuario_id] = usuario.id
      redirect_to tienda_url
    else
      redirect_to login_url, alert: "Combinación usuarios / contraseña inválida."
    end
  end

  def destroy
    session[:usuario_id] = nil
    redirect_to tienda_url, notice: "Logged out"    
  end
end
