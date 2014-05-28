class ChangePhoneToString < ActiveRecord::Migration
  def change
  	change_column :venues, :phone, :string
  end
end
