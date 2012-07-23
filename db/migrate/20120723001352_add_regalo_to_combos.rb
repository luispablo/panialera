class AddRegaloToCombos < ActiveRecord::Migration
  def change
    add_column :combos, :regalo, :boolean

  end
end
