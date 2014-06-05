class Venue < ActiveRecord::Base
  belongs_to :owner
  has_many :performances
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  validates_presence_of :name
  # validates_presence_of :street_address_1
  # validates_presence_of :city
  # validates_presence_of :zip
  # validates_presence_of :phone
  # validates_length_of :zip, is: 5
  # validates :phone, format: { with: /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/, message: "bad format" }
  # validates :website, format: { with: /^((http|https):\/\/)?[a-z0-9]+([-.]{1}[a-z0-9]+).[a-z]{2,5}(:[0-9]{1,5})?(\/.)?$/ix,  :multiline => true }, :allow_blank => true

end