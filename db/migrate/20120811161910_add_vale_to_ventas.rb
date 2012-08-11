class AddValeToVentas < ActiveRecord::Migration
  def change
  	change_table :ventas do |t|
  		t.string :codigo_vale
  		t.float :valor_descuento
  	end
  end
end
