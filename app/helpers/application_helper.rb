module ApplicationHelper

  def pretty_number(number)
    if number > 0
      if (number - number.to_i) == 0
        number.to_i
      else
        number
      end 
    else
        '-'
    end
  end

  def control_group_class(objeto, campo)
    %{control-group #{'error' unless objeto.read_attribute(campo).nil? or objeto.valid?(campo)}}
  end

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
