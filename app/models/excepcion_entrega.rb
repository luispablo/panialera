# == Schema Information
#
# Table name: excepcion_entregas
#
#  id         :integer         not null, primary key
#  fecha      :date
#  hora_desde :time
#  hora_hasta :time
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class ExcepcionEntrega < ActiveRecord::Base
end
