# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
  
  inflect.irregular 'categoria', 'categorias'
  inflect.irregular 'compra_detalle', 'compra_detalles'
  inflect.irregular 'venta', 'ventas'
  inflect.irregular 'venta_detalle', 'venta_detalles'
  inflect.irregular 'proveedor', 'proveedores'
  
#   inflect.uncountable %w( fish sheep )
end
#
# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.acronym 'RESTful'
# end
