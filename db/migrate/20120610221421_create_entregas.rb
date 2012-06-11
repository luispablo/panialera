class CreateEntregas < ActiveRecord::Migration
  def change
    create_table :entregas do |t|
      t.integer :wday
      t.time :desde
      t.time :hasta
      t.boolean :disponible

      t.timestamps
    end
  end
end
