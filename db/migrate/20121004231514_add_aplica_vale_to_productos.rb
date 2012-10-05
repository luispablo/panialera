class AddAplicaValeToProductos < ActiveRecord::Migration
  def change
		change_table :productos do |t|
			t.boolean :aplica_vale, default: true
		end
  end
end
