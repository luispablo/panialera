module ApplicationHelper

	def boolean_listado(objeto, campo)
		best_in_place objeto, campo, type: :checkbox, collection: ['<i class="icon-remove"></i>'.html_safe, '<i class="icon-ok"></i>'.html_safe]
	end

	def quitar_brs(texto)
		texto.gsub("<br>"," ").gsub("<br/>"," ").gsub("<BR>"," ").gsub("<BR/>"," ")
	end

  def link_to_submit(texto, icono = nil, clase)
    html_icono = "<i class='icon-#{icono} icon-white'></i> " unless icono.nil?
    link_to_function "#{html_icono unless icono.nil?}#{texto}".html_safe, "$(this).closest('form').submit()", class: "btn #{clase}"
  end

  def texto_boton_carrito(producto)
    puede_comprar?(producto) ? t('botones.agregar_carrito') : t('botones.sin_stock')
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    icono = (column == sort_column) ? "<i class='icon-chevron-#{(sort_direction == 'asc') ? 'up': 'down'}'></i>" : ''
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to "#{title} #{icono}".html_safe, params.merge(:sort => column, :direction => direction, :page => nil) 
  end

  def pretty_number(number)
    unless number.nil? or number <= 0
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
  
  def item_menu(controller, ruta, texto = nil)
    clase = 'active' if controller == params[:controller]
    raw("<li class='#{clase}'><a href='#{ruta}'>#{texto.nil? ? controller.capitalize : texto}</a></li>")
  end
  
end
