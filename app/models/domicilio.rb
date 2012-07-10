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
#

class Domicilio < ActiveRecord::Base
  belongs_to :barrio
  belongs_to :usuario

  has_many :ventas
  
  after_save :notificar
  
  def descripcion
    "#{calle} #{numero} #{piso} #{depto}"
  end
  
protected
  def notificar
    if valido_delivery.nil?
      # Apenas se crea, notificar a los administradores
      notificar_validacion_pendiente
    elsif valido_delivery_changed?
      if valido_delivery?
        validar
      else
        invalidar
      end
    end     
  end
  
  def validar
    if ventas.nil? or ventas.empty?
      AdminMailer.domicilio_valido(self).deliver
    else
      ventas.each do |v|
        VentaNotifier.confirmada(v).deliver
      end
    end
  end
  
  def invalidar
    unless ventas.nil? or ventas.empty?
      ventas.each do |v|
        v.destroy
      end
    end
    
    AdminMailer.domicilio_invalido(self).deliver    
  end
  
  def notificar_validacion_pendiente
    Usuario.where(administrador: true).each do |admin|
      unless admin.email.nil?
        AdminMailer.domicilio_a_validar(self, admin.email).deliver
      end
    end    
  end
end
