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
  
  def descripcion
    "Este #{DIAS_SEMANA[wday]} (#{fecha.day}/#{fecha.month}) entre las #{desde.strftime('%H:%M')} y las #{hasta.strftime('%H:%M')} hs."
  end
  
  def self.entregas_disponibles
    entregas = Entrega.proximas_entregas(Date.today)
    
    unless entregas.nil? or entregas.empty?      
      (Parametro.dias_disponibles_entrega - 1).times do |i|
        entregas += Entrega.proximas_entregas(entregas.last.fecha.next_day) 
      end
    end
    
    entregas
  end
  
  def self.proximas_entregas(fecha)
    (fecha..fecha.next_day(6)).each do |f|
      entregas = Entrega.where(wday: f.wday).each { |e| e.fecha = f }
      
      if f == Date.today
        hora_desde = Time.now + Parametro.horas_cierre_entrega.hour
        
        entregas.each do |e|          
          entregas.delete(e) unless e.desde.hour > hora_desde.hour or e.desde.hour == hora_desde.hour and e.desde.min > hora_desde.min
        end
      end       
      
      return entregas unless entregas.empty?
    end
    
    return nil
  end
  
end
