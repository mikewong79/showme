class ChangeZipToString < ActiveRecord::Migration
  def change
  	change_column :venues, :zip, :string
  end
end
