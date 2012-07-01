class AddComboToComboDetalles < ActiveRecord::Migration
  def change
    change_table :combo_detalles do |t|
      t.references :combo
    end
  end
end
