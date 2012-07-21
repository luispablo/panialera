class AddDeletedAtToDomicilios < ActiveRecord::Migration
  def change
		change_table :domicilios do |t|
			t.datetime :deleted_at
		end
  end
end
