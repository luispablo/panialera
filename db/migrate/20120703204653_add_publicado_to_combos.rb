class AddPublicadoToCombos < ActiveRecord::Migration
  def change
    add_column :combos, :publicado, :boolean

  end
end
