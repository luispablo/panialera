# == Schema Information
#
# Table name: categorias
#
#  id           :integer         not null, primary key
#  codigo       :string(255)
#  nombre       :string(255)
#  descripcion  :string(255)
#  categoria_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  publicado    :boolean
#  orden        :integer
#

class Categoria < ActiveRecord::Base
  belongs_to :categoria
  
  has_many :cat_productos
  has_many :categorias
  has_many :productos, :through => :cat_productos

  validates :codigo, uniqueness: true, presence: true
  
  def hijas
	Categoria.where(categoria_id: id).order(:orden)
  end
  
  def todos_productos(orden = nil)
    productos = self.productos 
    
    categorias.each do |hija|
      productos += hija.todos_productos(orden)
    end
    
    return productos.sort { |a, b| a.comparar(b, orden) }.find_all { |p| p.publicado }
  end
  
  def seleccionada?(sel)
    return (not sel.nil? and (id == sel.id))
  end
  
  def hijas_publicadas
    hijas.find_all { |hija| hija.publicado? }
  end
  
  def hija_seleccionada?(categoria)
    unless categoria.nil?
      unless categorias.nil? or categorias.empty?
        categorias.each do |hija|
          if hija.id == categoria.id or hija.hija_seleccionada?(categoria)
            return true
          end
        end
      end      
    end
    
    return false
  end
  
  def self.categorias_madre_publicadas
    Categoria.where(publicado: true, categoria_id: nil).order(:orden)
  end
  
end
