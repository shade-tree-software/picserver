class AddNotesToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :notes, :string
  end
end
