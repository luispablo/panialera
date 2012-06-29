class AddValidoDeliveryToDomicilios < ActiveRecord::Migration
  def change
    add_column :domicilios, :valido_delivery, :boolean

  end
end
