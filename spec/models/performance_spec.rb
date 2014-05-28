require 'spec_helper'

describe Performance do
	describe "Validate Date and Time"do
		it {should validate_presence_of(:date)}
		it {should validate_presence_of(:time)}
	end
end
