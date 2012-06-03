class MiCuentaController < ApplicationController
  before_filter :cargar_carrito
  before_filter :cargar_usuario

  def cambio_clave
    if request.post?
      @usuario = Usuario.find(params[:id])
      
      unless @usuario.email == params[:email]
        flash[:error] = "El e-mail ingresado es inválido."
        return
      end
      
      if params[:password] == params[:confirmation]
        @usuario.password = params[:password]
        
        flash[:notice] = "Contraseña grabada con éxito" if @usuario.save
      else
        flash[:error] = "La contraseña no coincide con la confirmación."
      end
    end
    
    respond_to do |format|
      format.html
      format.js
    end    
  end

  def datos_personales
    
  end
  
  def vales
    
  end
  
  def domicilios
    
  end
  
  def pedidos
    
  end
  
private
  def cargar_usuario
    @usuario = Usuario.find(params[:id])
  end
end
