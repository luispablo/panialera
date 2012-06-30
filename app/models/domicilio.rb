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
  
  after_save :notificar_domicilio_a_validar
  
  def invalidar_para_delivery
    self.valido_delivery = false
    save
    
    AdminMailer.domicilio_invalido(self).deliver    
  end
  
  def validar_para_delivery
    self.valido_delivery = true
    save
    
    if ventas.nil? or ventas.empty?
      AdminMailer.domicilio_valido(self).deliver
    else
      ventas.each do |v|
        VentaNotifier.confirmada(v).deliver
      end
    end
    
  end
  
  def descripcion
    "#{calle} #{numero} #{piso} #{depto}"
  end
  
protected
  def notificar_domicilio_a_validar
    if self.valido_delivery.nil?
      Usuario.where(administrador: true).each do |admin|
        unless admin.email.nil?
          AdminMailer.domicilio_a_validar(self, admin.email).deliver
        end
      end
    end     
  end
end
