class AddComentariosToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :comentarios, :string
  end
end
