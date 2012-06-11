class AddUltimaEntregaToDomicilios < ActiveRecord::Migration
  def change
    add_column :domicilios, :ultima_entrega, :boolean

  end
end
