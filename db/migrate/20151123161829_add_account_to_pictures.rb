class AddAccountToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :account, :string
  end
end
