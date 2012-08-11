class ChangeFieldsFromVales < ActiveRecord::Migration
  def change
  	change_table :vales do |t|
  		t.remove :valor
  		t.float :porcentaje_descuento
  		t.boolean :utilizado
  	end
  end
end
