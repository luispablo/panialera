class AdminMailer < ActionMailer::Base

  def domicilio_invalido(domicilio)
    @domicilio = domicilio
    @usuario = domicilio.usuario
    
    mail to: @usuario.email, from: Parametro.remitente_mails, subject: 'Domicilio fuera del rango de entrega'
  end

  def domicilio_valido(domicilio)
    @domicilio = domicilio
    @usuario = domicilio.usuario
    
    mail to: @usuario.email, from: Parametro.remitente_mails, subject: 'Domicilio confirmado'
  end

  def domicilio_a_validar(domicilio, to)
    @domicilio = domicilio
    
    mail to: to, from: Parametro.remitente_mails, subject: 'Domicilio a validar'
  end

end
