class AddExpiryToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :expiry, :integer
  end
end
