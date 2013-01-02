class VentaNotifier < ActionMailer::Base

  def pendiente_conf_domicilio(venta)
    @venta = venta
    @usuario = venta.usuario
    @domicilio = venta.domicilio

		unless venta.usuario.nil?
			mail to: venta.usuario.email, from: Parametro.remitente_mails, subject: 'Compra pendiente de confirmación'    
		end
  end
  
  def confirmada(venta)
    @venta = venta

    mail to: venta.usuario.email, from: Parametro.remitente_mails, subject: 'Compra confirmada'
  end
	
	def venta_confirmada(venta)
		@venta = venta
		
		mail to: Parametro.remitente_mails, from: Parametro.remitente_mails, subject: 'Venta confirmada'
	end
end
