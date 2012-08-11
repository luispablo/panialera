class RemoveUsuarioIdFromVales < ActiveRecord::Migration
  def change
  	change_table :vales do |t|
  		t.remove :usuario_id
  	end
  end
end
