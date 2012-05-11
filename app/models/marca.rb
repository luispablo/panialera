# == Schema Information
#
# Table name: marcas
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Marca < ActiveRecord::Base
  has_many :productos
end
