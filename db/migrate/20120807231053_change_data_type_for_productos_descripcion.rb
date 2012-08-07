class ChangeDataTypeForProductosDescripcion < ActiveRecord::Migration
  def change
  	change_table :productos do |t|
  		t.change :descripcion, :text
  	end
  end
end
