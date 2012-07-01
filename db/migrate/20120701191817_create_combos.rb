class CreateCombos < ActiveRecord::Migration
  def change
    create_table :combos do |t|
      t.string :codigo
      t.float :precio

      t.timestamps
    end
  end
end
