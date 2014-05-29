class Venue < ActiveRecord::Base
  belongs_to :owner
  has_many :performances

  validates_presence_of :name
  validates_presence_of :street_address_1
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :phone
  validates_length_of :state, is: 2
  validates_length_of :zip, is: 5
  validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad format" }
  validates_format_of :website, with: URI.regexp

end
