class AddConfirmadaToVentas < ActiveRecord::Migration
  def change
    add_column :ventas, :confirmada, :boolean

  end
end
