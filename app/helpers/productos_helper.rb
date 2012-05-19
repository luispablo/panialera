module ProductosHelper
  def nombres_categorias(producto)
    nombres = ""
    producto.categorias.each { |c| nombres += c.nombre + " " }
    nombres
  end
end
