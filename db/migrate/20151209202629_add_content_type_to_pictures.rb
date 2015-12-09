class AddContentTypeToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :string, :content_type
  end
end
