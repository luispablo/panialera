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

  def fecha_hora_desde
    DateTime.new(fecha.year, fecha.month, fecha.day, hora_desde.hour, hora_desde.min)
  end
  
  def fecha_hora_hasta
    DateTime.new(fecha.year, fecha.month, fecha.day, hora_hasta.hour, hora_hasta.min)
  end

  def incluye_entrega?(entrega)
    self.fecha_hora_desde <= entrega.fecha_hora_hasta && self.fecha_hora_hasta >= entrega.fecha_hora_desde 
  end
  
  def self.aplicables
    ExcepcionEntrega.where("fecha >= :hoy", hoy: Date.today)
  end
  
end
