class RemoveEsRegaloFromCombos < ActiveRecord::Migration
  def change
  	change_table :combos do |t|
  		t.remove :regalo
  		t.boolean :destacado
  	end
  end
end
