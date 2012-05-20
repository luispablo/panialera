class CreateCarritos < ActiveRecord::Migration
  def change
    create_table :carritos do |t|

      t.timestamps
    end
  end
end
