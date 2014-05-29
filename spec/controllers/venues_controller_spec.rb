require 'spec_helper'

describe VenuesController do
  let(:valid_venue) {{name: "Santa Monica Mall", street_address_1: "1520 2nd Street",city: "Santa Monica", state: "CA", zip: "90405",phone:"732-604-1166", website: "http://www.kriscoulson.com"}}

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
    it "should show all venues" do
      venue = Venue.create! valid_venue
      venue_clone = Venue.create! valid_venue
        get 'index'
        expect(assigns(:venues)).to eq ([venue, venue_clone])
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      venue1 = Venue.create! valid_venue
      get :show, id: venue1
      response.should be_success
    end
    it "should return Santa Monica Mall Venue" do
    venue1 = Venue.create! valid_venue
      get :show, id: venue1.id
        expect(assigns(:venue)).to eq(venue1)
    end
  end

   describe "GET 'new'" do
    before do
      get :new
    end

    it "should render the new template" do
      expect(response).to render_template :new
    end

    it "should succeed" do
      expect(response).to be_success
    end

    it "should assign a new venue" do
      expect(assigns(:venue)).to be_a(Venue)
      expect(assigns(:venue)).to_not be_persisted
    end
  end

  describe "POST create" do
    describe "successful create" do
      it "should save a new Venue to the database" do
        expect do
          post :create, venue: valid_venue
        end.to change(Venue, :count).by(1)
      end

      it "should redirect to the index action" do
        post :create, venue: valid_venue
        expect(response).to redirect_to venues_path
      end
    end
    describe "not able to save" do
      let :invalid_venue do
        {
          :name => nil
        }
      end

      it "should save a new Venue to the database" do
        expect do
          post :create, venue: invalid_venue
        end.to_not change(Venue, :count).by(1)
      end

      it "should rerender the new template" do
        post :create, venue: invalid_venue
        expect(response).to render_template :new
      end
    end
  end

  describe "GET edit" do
    before do
      @venue1 = Venue.create! valid_venue
      get :edit, id: @venue1.id
    end

    it "should render the index template" do
      expect(response).to render_template :edit
    end

    it "should succeed" do
      expect(response).to be_success
    end

    it "should assign venue1 to all venues" do
      expect(assigns(:venue)).to eq(@venue1)
    end
  end



end
