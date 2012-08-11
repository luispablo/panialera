class AddValeToCarritos < ActiveRecord::Migration
  def change
  	change_table :carritos do |t|
  		t.references :vale
  	end
  end
end
