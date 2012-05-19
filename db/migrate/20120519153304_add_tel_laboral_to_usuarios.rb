class AddTelLaboralToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :tel_laboral, :string

  end
end
