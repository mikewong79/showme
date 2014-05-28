require 'spec_helper'



describe Owner do
	
	describe "Validate all fields in Owner Model" do
 		
 		it {should validate_presence_of(:first_name)}
  		it {should validate_presence_of(:last_name)}
  		it {should validate_presence_of(:email)}
  		it {should validate_uniqueness_of(:email)}
  	end
  	describe "Validate Emails" do
  		it {should allow_value("KrisCoulson@gmail.com","Shane@shane.com","Ryan@ryan.net").for(:email)}
  		it {should_not allow_value("dasjdkj","asdasdas.com","hol5@").for(:email)}
  	end
end
