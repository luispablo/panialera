class CreateComboDetalles < ActiveRecord::Migration
  def change
    create_table :combo_detalles do |t|
      t.references :producto
      t.integer :cantidad

      t.timestamps
    end
    add_index :combo_detalles, :producto_id
  end
end
