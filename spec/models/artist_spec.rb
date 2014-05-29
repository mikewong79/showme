require 'spec_helper'

describe Artist do
  describe "validate presence of name" do
    it {should validate_presence_of(:name)}
  end

  describe "Artist has and belongs to many Performances" do
    it {should have_and_belong_to_many(:performances)}
  end
end
