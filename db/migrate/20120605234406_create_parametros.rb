class CreateParametros < ActiveRecord::Migration
  def change
    create_table :parametros do |t|
      t.string :codigo
      t.string :nombre
      t.string :valor

      t.timestamps
    end
  end
end
