class Performance < ActiveRecord::Base
  belongs_to :venue
  has_and_belongs_to_many :artists

  validates_presence_of :date
  validates_presence_of :time
end
