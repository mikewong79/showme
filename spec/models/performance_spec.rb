require 'spec_helper'

describe Performance do
  describe "Validate all date and time in Performance Model" do
    it {should validate_presence_of(:date)}
    it {should validate_presence_of(:time)}
  end

  describe "should belong to a venue" do
    it {should belong_to(:venue)}
  end

  describe "Performance has and belongs to many Artists" do
    it {should have_and_belong_to_many(:artists)}
  end

end
