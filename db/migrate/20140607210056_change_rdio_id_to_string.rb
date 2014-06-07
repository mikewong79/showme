class ChangeRdioIdToString < ActiveRecord::Migration
  def change
    change_column :artists, :rdio_id, :string
  end
end
