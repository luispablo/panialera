class ChangeDataTypeForProductosDescripcion < ActiveRecord::Migration
  def change
  	change_table :productos do |t|
  		t.change :detalle, :text
  	end
  end
end
