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
    "#{DIAS_SEMANA[wday]} #{fecha.day} de #{desde.strftime('%H:%M')} a #{hasta.strftime('%H:%M')}"
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
      
      return entregas unless entregas.empty?
    end
    
    return nil
  end
  
end
