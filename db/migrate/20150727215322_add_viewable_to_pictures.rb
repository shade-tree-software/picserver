class AddViewableToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :viewable, :boolean
  end
end
