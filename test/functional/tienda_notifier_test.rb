require 'test_helper'

class TiendaNotifierTest < ActionMailer::TestCase
  test "consulta" do
    mail = TiendaNotifier.consulta
    assert_equal "Consulta", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
