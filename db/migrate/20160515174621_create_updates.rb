class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :version
      t.string :date

      t.timestamps null: false
    end
  end
end
