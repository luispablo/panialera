class MiCuentaController < ApplicationController
  before_filter :cargar_carrito
  before_filter :cargar_usuario

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
