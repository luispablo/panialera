class MiCuentaController < ApplicationController
  before_filter :cargar_carrito
  
  def resumen
    @usuario = Usuario.find(params[:id])
  end
  
end
