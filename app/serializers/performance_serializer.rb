class PerformanceSerializer < ActiveModel::Serializer
  attributes :id, :name, :date, :time, :venue_id, :songkick_id
  has_many :artists
end
