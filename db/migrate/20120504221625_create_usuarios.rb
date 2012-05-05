class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.string :apellido
      t.string :sexo
      t.string :tel_particular
      t.string :tel_celular
      t.string :email

      t.timestamps
    end
  end
end
