class UsuarioNotifier < ActionMailer::Base

	def bienvenida(usuario)
		@usuario = usuario
		
		mail to: usuario.email, from: Parametro.remitente_mails, subject: '¡Bienvenida/o a Pañalera Digital!'
	end

end

