class AddUsuarioToVales < ActiveRecord::Migration
  def change
    change_table :vales do |t|
      t.references :usuario
    end
  end
end
