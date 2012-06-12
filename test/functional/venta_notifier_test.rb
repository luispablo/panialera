require 'test_helper'

class VentaNotifierTest < ActionMailer::TestCase
  test "confirmada" do
    mail = VentaNotifier.confirmada
    assert_equal "Confirmada", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
