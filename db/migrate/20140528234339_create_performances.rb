class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.string :name
      t.date :date
      t.time :time
      t.string :description
      t.references :venue, index: true

      t.timestamps
    end
  end
end
