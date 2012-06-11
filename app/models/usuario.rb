# == Schema Information
#
# Table name: usuarios
#
#  id              :integer         not null, primary key
#  nombre          :string(255)
#  apellido        :string(255)
#  sexo            :string(255)
#  tel_particular  :string(255)
#  tel_celular     :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  tel_laboral     :string(255)
#  password_digest :string(255)
#  administrador   :boolean
#

class Usuario < ActiveRecord::Base
  has_many :domicilios
  has_many :ventas
  has_many :hijos
  has_many :vales
  
  validates :nombre, :apellido, :email, :presence => { :message => ' es un campo requerido.'}
  validates :email, uniqueness: true
  
  has_secure_password
  
  def domicilio_ultima_entrega
    unless domicilios.nil? or domicilios.empty?
      domicilios.each do |d|
        return d if d.ultima_entrega
      end
      
      domicilio_ultima_entrega = domicilios.first
      domicilio_ultima_entrega.ultima_entrega = true
      domicilio_ultima_entrega
    else
      Domicilio.new(usuario: self, ultima_entrega: true)
    end
  end
    
end
