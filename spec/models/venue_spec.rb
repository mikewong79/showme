require 'spec_helper'

describe Venue do
	describe "validate presence of fields" do
	  	it {should validate_presence_of(:name)}
	  	it {should validate_presence_of(:street_address_1)}
	  	it {should validate_presence_of(:city)}
	  	it {should validate_presence_of(:state)}
	  	it {should validate_presence_of(:zip)}
	  	it {should validate_presence_of(:phone)}
	end
	describe "length of state should be two" do
		it { should ensure_length_of(:state).is_equal_to(2) }
	end
	describe "zip code is 5 characters" do
		it { should ensure_length_of(:zip).is_equal_to(5) }
	end
	describe "phone number is valid format" do
		it {should allow_value("723-237-9088","301-867-5309","210-576-6542").for(:phone)}
  		it {should_not allow_value("1234567890","123-fed-1234","123-324-345").for(:phone)}
  	end
  	
end
