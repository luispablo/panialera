module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    icono = (column == sort_column) ? "<i class='icon-chevron-#{(sort_direction == 'asc') ? 'up': 'down'}'></i>" : ''
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to "#{title} #{icono}".html_safe, params.merge(:sort => column, :direction => direction, :page => nil) 
  end

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

  def trunc(texto, longitud, sufijo)
    "#{texto.slice(0, longitud).strip}#{sufijo if (texto.length > longitud)}"
  end
  
  def control_group_class(objeto, campo)
    %{control-group #{'error' unless objeto.read_attribute(campo).nil? or objeto.valid?(campo)}}
  end

  def tab(etiqueta, path)
    raw("<li #{"class='active'" if request.fullpath.include?(path)}>#{link_to(etiqueta, path)}</li>")
  end

  def usuario_logueado?
    not session[:usuario_id].nil?
  end
  
  def item_menu(controller, ruta)
    clase = 'active' if controller == params[:controller]
    raw("<li class='#{clase}'><a href='#{ruta}'>#{controller.capitalize}</a></li>")
  end
  
end
