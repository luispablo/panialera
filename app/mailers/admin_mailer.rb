class AdminMailer < ActionMailer::Base

  def domicilio_a_validar(domicilio, to)
    @domicilio = domicilio
    
    mail to: to, from: Parametro.remitente_mails, subject: 'Domicilio a validar'
  end

end
