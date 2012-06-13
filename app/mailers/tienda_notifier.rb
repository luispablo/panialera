class TiendaNotifier < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tienda_notifier.consulta.subject
  #
  def consulta(nombre, como_llego, email, consulta, quiere_recibir)
    @nombre = nombre
    @como_llego = como_llego
    @email = email
    @consulta = consulta
    @quiere_recibir = quiere_recibir

    mail to: Parametro.email_admin, from: Parametro.remitente_mails, subject: 'Consulta', reply_to: email
  end
end
