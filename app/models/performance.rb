class Performance < ActiveRecord::Base
  belongs_to :venue

	validates_presence_of :date
	validates_presence_of :time
end
