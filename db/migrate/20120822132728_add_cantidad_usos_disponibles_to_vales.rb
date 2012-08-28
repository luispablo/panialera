class AddCantidadUsosDisponiblesToVales < ActiveRecord::Migration
  def change
  	change_table :vales do |t|
  		t.integer :cantidad_usos_disponibles
  		t.remove :utilizado
  	end
  end
end
