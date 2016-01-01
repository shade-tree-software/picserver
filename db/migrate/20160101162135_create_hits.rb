class CreateHits < ActiveRecord::Migration
  def change
    create_table :hits do |t|
      t.integer :picture_id
      t.string :source
      t.string :status

      t.timestamps null: false
    end
  end
end
