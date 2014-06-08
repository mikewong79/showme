class VenueSerializer < ActiveModel::Serializer
  attributes :id, :name, :street_address_1, :city, :state, :zip, :website, :phone, :lat, :lng
  has_many :performances
  
end
