class SessionsController < ApplicationController
  before_filter :cargar_carrito
  
  def registro
    @usuario = Usuario.new
  end
  
  def create_usuario
    @usuario = Usuario.new(params[:usuario])
    @usuario.administrador = false

    respond_to do |format|
      if @usuario.save
        format.html do
          if session[:url_original]
            session[:usuario_id] = @usuario.id
            url = session[:url_original]
            session[:url_original] = nil
            
            redirect_to url  
          else
            redirect_to tienda_url, notice: "Usuario #{@usuario.email} registrado con éxito."
          end
        end
      else
        format.html { render action: 'registro' }
      end
    end    
  end
  
  def login_or_register
    session[:url_original] = new_venta_path    
  end
  
  def new
  end

  def create
    usuario = Usuario.find_by_email(params[:email])
    
    if usuario and usuario.authenticate(params[:password])
      session[:usuario_id] = usuario.id
      
      if params[:redirect_to]
        redirect_to params[:redirect_to] 
      else
        redirect_to tienda_url
      end
    else
      redirect_to login_url, alert: "Combinación usuarios / contraseña inválida."
    end
  end

  def destroy
    session[:usuario_id] = nil
    redirect_to tienda_url, notice: "Sesión cerrada"    
  end
end
