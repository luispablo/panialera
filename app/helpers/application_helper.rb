module ApplicationHelper

  def tab(etiqueta, path)
    raw("<li #{"class='active'" if request.fullpath.include?(path)}>#{link_to(etiqueta, path)}</li>")
  end

  def trunc(texto, longitud, sufijo)
    "#{texto.slice(0, longitud).strip}#{sufijo if (texto.length > longitud)}"
  end

  def usuario_logueado?
    not session[:usuario_id].nil?
  end
  
  def item_menu(controller, ruta)
    clase = 'active' if controller == params[:controller]
    raw("<li class='#{clase}'><a href='#{ruta}'>#{controller.capitalize}</a></li>")
  end
  
end
