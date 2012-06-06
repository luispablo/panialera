# == Schema Information
#
# Table name: parametros
#
#  id         :integer         not null, primary key
#  codigo     :string(255)
#  nombre     :string(255)
#  valor      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Parametro < ActiveRecord::Base
  CODIGOS = 
  {
      precio_envio: 'PRECIO_ENVIO', 
      monto_minimo_sin_envio: 'MONTO_MINIMO_SIN_ENVIO'
  }
  VALORES_POR_DEFECTO =
  {
      precio_envio: '15',
      monto_minimo_sin_envio: '120'
  }
  
  validates :valor, presence: { message: ' el campo es requerido.' } 
end
