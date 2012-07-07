# == Schema Information
#
# Table name: entregas
#
#  id         :integer         not null, primary key
#  wday       :integer
#  desde      :time
#  hasta      :time
#  disponible :boolean
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Entrega < ActiveRecord::Base
  attr_accessor :fecha
  
  def fecha_hora_desde
    DateTime.new(fecha.year, fecha.month, fecha.day, desde.hour, desde.min)
  end
  
  def fecha_hora_hasta
    DateTime.new(fecha.year, fecha.month, fecha.day, hasta.hour, hasta.min)
  end
  
  def horario_corto
    "entre #{desde.strftime('%H:%M')} y #{hasta.strftime('%H:%M')} hs."
  end
  
  def horario
    "entre las #{desde.strftime('%H:%M')} y las #{hasta.strftime('%H:%M')}"
  end
  
  def descripcion
    "Este #{DIAS_SEMANA[wday]} (#{fecha.day}/#{fecha.month}) #{horario} hs."
  end
  
  def self.entregas_disponibles
    entregas = Entrega.proximas_entregas(Date.today)
    
    unless entregas.nil? or entregas.empty?      
      (Parametro.dias_disponibles_entrega - 1).times do |i|
        entregas += Entrega.proximas_entregas(entregas.last.fecha.next_day) 
      end
    end
    
    unless entregas.nil?
      entregas
    else
      nil
    end
  end
  
  # Valida que la entrega del mismo día todavía le falten más de las
  # horas definidas por parámetro para estar cerrada.
  def cerrada?    
    # Desde que hora todavía se puede hacer entrega, en base al parámetro
    hora_desde_valida = Time.now + Parametro.horas_cierre_entrega.hour

    fecha == Date.today and (fecha != hora_desde_valida.to_date or desde.hour < hora_desde_valida.hour or (desde.hour == hora_desde_valida.hour and desde.min <= hora_desde_valida.min))
  end
  
  def self.proximas_entregas(fecha)
    (fecha..fecha.next_day(6)).each do |f|
      entregas = Entrega.where(wday: f.wday).each { |e| e.fecha = f }
      no_cerradas = entregas.find_all { |e| not e.cerrada? }
      
      return no_cerradas unless no_cerradas.empty?
    end
    
    return nil
  end
  
end
