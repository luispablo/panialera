# == Schema Information
#
# Table name: domicilios
#
#  id              :integer         not null, primary key
#  nombre          :string(255)
#  calle           :string(255)
#  numero          :integer
#  piso            :string(255)
#  depto           :string(255)
#  entre_calles    :string(255)
#  codigo_postal   :string(255)
#  barrio_id       :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  usuario_id      :integer
#  ultima_entrega  :boolean
#  valido_delivery :boolean
#  deleted_at      :datetime
#

require 'test_helper'

class DomicilioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
