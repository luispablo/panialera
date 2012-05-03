module ApplicationHelper
  
  def item_menu(controller, ruta)
    clase = 'active' if controller == params[:controller]
    raw("<li class='#{clase}'><a href='#{ruta}'>#{controller.capitalize}</a></li>")
  end
  
end
