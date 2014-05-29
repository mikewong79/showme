class Artist < ActiveRecord::Base
  has_and_belongs_to_many :performances

  validates_presence_of :name

end
