# == Schema Information
#
# Table name: vales
#
#  id          :integer         not null, primary key
#  codigo      :string(255)
#  nombre      :string(255)
#  descripcion :string(255)
#  valor       :float
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Vale < ActiveRecord::Base
end