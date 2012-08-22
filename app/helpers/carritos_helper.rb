module CarritosHelper

	def puede_comprar?(item)
		(item.stock_disponible - (@carrito.nil? ? 0 : @carrito.cantidad_agregada(item))) > 0
	end

end
