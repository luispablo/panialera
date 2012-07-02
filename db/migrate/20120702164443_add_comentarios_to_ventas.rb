class AddComentariosToVentas < ActiveRecord::Migration
  def change
    add_column :ventas, :comentarios, :string

  end
end
