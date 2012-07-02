class AddImagenToCombos < ActiveRecord::Migration
  def change
    add_column :combos, :imagen, :string

  end
end
