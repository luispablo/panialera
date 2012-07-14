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
      dias_disponibles_entrega: 'DIAS_DISP_ENTREGA',
      email_admin: 'EMAIL_ADMIN',
      horas_cierre_entrega: 'HORAS_CIERRE_ENTREGA',
      items_por_pagina: 'ITEMS_POR_PAGINA',
      precio_envio: 'PRECIO_ENVIO', 
      monto_minimo_sin_envio: 'MONTO_MINIMO_SIN_ENVIO',
      remitente_mails: 'REMITENTE_MAILS',
      titulo_dest_rotativo: 'TITULO_DEST_ROTATIVO'
  }
  VALORES_POR_DEFECTO =
  {
      dias_disponibles_entrega: '3',
      email_admin: 'panialeradigital@gmail.com',
      horas_cierre_entrega: '3',
      items_por_pagina: '20',
      precio_envio: '15',
      monto_minimo_sin_envio: '120',
      remitente_mails: '"Pañalera Digital" <panialeradigital@gmail.com>',
      titulo_dest_rotativo: 'Destacados <br/>D&Iacute;A DEL NI&Ntilde;O'
  }
  
  validates :valor, presence: { message: ' el campo es requerido.' }
  validates :codigo, uniqueness: true
  
  def self.titulo_destacado_rotativo
    Parametro.find_by_codigo(CODIGOS[:titulo_dest_rotativo]).valor
  end
  
  def self.items_por_pagina
    Parametro.find_by_codigo(CODIGOS[:items_por_pagina]).valor.to_i
  end
  
  def self.horas_cierre_entrega
    Parametro.find_by_codigo(CODIGOS[:horas_cierre_entrega]).valor.to_i
  end
  
  def self.email_admin
    Parametro.find_by_codigo(CODIGOS[:email_admin]).valor
  end
  
  def self.remitente_mails
    Parametro.find_by_codigo(CODIGOS[:remitente_mails]).valor
  end
  
  def self.dias_disponibles_entrega
    Parametro.find_by_codigo(CODIGOS[:dias_disponibles_entrega]).valor.to_i
  end
  
  def self.precio_envio
    Parametro.find_by_codigo(CODIGOS[:precio_envio]).valor.to_f
  end 
  
  def self.monto_minimo_sin_envio
    Parametro.find_by_codigo(CODIGOS[:monto_minimo_sin_envio]).valor.to_f
  end
end
