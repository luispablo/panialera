class VentaNotifier < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.venta_notifier.confirmada.subject
  #
  def confirmada(venta)
    @venta = venta

    mail to: venta.usuario.email, from: Parametro.remitente_mails, subject: 'Compra confirmada'
  end
end
