class AddAplicaValeToCombos < ActiveRecord::Migration
  def change
		change_table :combos do |t|
			t.boolean :aplica_vale, default: true
		end
  end
end
