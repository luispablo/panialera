module CarritosHelper

	def puede_comprar?(item)
		(item.stock_disponible - @carrito.cantidad_agregada(item)) > 0
	end

end
