class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :street_address_1
      t.string :street_address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :website
      t.integer :phone
      t.string :ticket_link
      t.string :photo
      t.references :owner, index: true

      t.timestamps
    end
  end
end
