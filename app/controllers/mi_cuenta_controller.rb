class MiCuentaController < ApplicationController
  before_filter :cargar_carrito
  before_filter :cargar_usuario

  def agregar_hijo
    if request.post?
      @hijo = Hijo.new(params[:hijo])
      @hijo.usuario = @usuario

      respond_to do |format|
        if @hijo.save
          format.html { redirect_to mi_cuenta_datos_personales_url, notice: "Se ha grabado la información." }
        else
          format.html { flash[:error] = "No se puede grabar la información." }
        end
      end    
    else              
      @hijo = Hijo.new(usuario: @usuario)
    end
  end

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
    @usuario = Usuario.find(params[:id] || session[:usuario_id])
  end
end
