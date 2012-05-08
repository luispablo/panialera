class CreateVales < ActiveRecord::Migration
  def change
    create_table :vales do |t|
      t.string :codigo
      t.string :nombre
      t.string :descripcion
      t.float :valor

      t.timestamps
    end
  end
end
