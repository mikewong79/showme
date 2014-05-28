class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.string :name
      t.string :date
      t.string :time
      t.string :description
      t.references :venue, index: true

      t.timestamps
    end
  end
end
