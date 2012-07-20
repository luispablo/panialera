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
	  logger.debug("No se sabe si es valido delivery, avisar a admins...")
      notificar_validacion_pendiente
    elsif valido_delivery_changed?
      if valido_delivery?
		logger.debug("Es valido")
        validar
      else
		logger.debug("No es valido")
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
	logger.debug("Se va a notificar a los admins...")
    Usuario.where("administrador = 1").each do |admin|
		logger.debug("Notificando a #{admin.nombre}")
		
		unless admin.email.nil?
			logger.debug("Enviando mail a #{admin.email}")
			AdminMailer.domicilio_a_validar(self, admin.email).deliver
		else
			logger.debug("Este admin no tiene mail")
		end		
    end    
  end
end
