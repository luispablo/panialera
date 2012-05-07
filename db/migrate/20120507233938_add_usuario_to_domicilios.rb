class AddUsuarioToDomicilios < ActiveRecord::Migration
  def change
    change_table :domicilios do |t|
      t.references :usuario
    end
  end
end
