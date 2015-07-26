class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :original_filename
      t.string :uid

      t.timestamps null: false
    end
  end
end
