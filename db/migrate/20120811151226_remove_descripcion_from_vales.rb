class RemoveDescripcionFromVales < ActiveRecord::Migration
  def change
  	change_table :vales do |t|
  		t.remove :descripcion
  	end
  end
end
