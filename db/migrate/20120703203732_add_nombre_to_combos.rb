class AddNombreToCombos < ActiveRecord::Migration
  def change
    add_column :combos, :nombre, :string

  end
end
