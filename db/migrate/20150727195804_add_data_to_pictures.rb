class AddDataToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :data, :binary
  end
end
