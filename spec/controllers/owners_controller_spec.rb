require 'spec_helper'

describe OwnersController do
  let(:valid_attributes) { { :first_name => "Joe", :last_name => "VenueOwner", :email => "venue@venue.com", :password => "password1"} }

  describe "GET index" do

    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "@owners should contain all the owners" do
      owner = Owner.create! valid_attributes
      owner2 = Owner.create!(:first_name => "Joe", :last_name => "VenueOwner", :email => "different@venue.com", :password => "password1" )
      get :index
      expect(assigns(:owners)).to include(owner)
      expect(assigns(:owners)).to include(owner2)

    end

    it "should render out the index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET show" do
    before(:each) do
      @owner = Owner.create! valid_attributes
      get :show, id: @owner.id
    end
    it "has a 200 status code" do
      expect(response.status).to eq(200)
    end

    it "@owner should contain the current owner" do
      expect(assigns(:owner)).to eq(@owner)
    end

    it "should render out the index template" do
      expect(response).to render_template :show
    end
  end

  describe "GET new" do
    before do
      get :new
    end

    it "should render the new template" do
      expect(response).to render_template :new
    end

    it "should succeed" do
      expect(response).to be_success
    end

    it "should assign a new owner" do
      expect(assigns(:owner)).to be_a(Owner)
      expect(assigns(:owner)).to_not be_persisted
    end
  end

  describe "GET edit" do
    before(:each) do
      @owner = Owner.create! valid_attributes
      get :edit, id: @owner.id
    end
    it "has a 200 status code" do
      expect(response.status).to eq(200)
    end

    it "@owner should contain the current owner" do
      expect(assigns(:owner)).to eq(@owner)
    end

    it "should render out the index template" do
      expect(response).to render_template :edit
    end
  end

  describe "POST create" do
    describe "successful create" do
      it "should save a new owner to the database" do
        expect do
          post :create, owner: valid_attributes
        end.to change(Owner, :count).by(1)
      end


    end

    describe "not able to save" do
      let :invalid_attributes do
        {
          :first_name => nil,
        }
      end
      it "should not save a new owner to the database" do
        expect do
          post :create, owner: invalid_attributes
        end.to_not change(Owner, :count).by(1)
      end
      it "should re-render the new template" do
        post :create, owner: invalid_attributes
        expect(response).to render_template :new
      end
    end
  end
end
