require 'spec_helper'

describe ArtistsController do
  let :valid_attributes do
    {
      :name => "test artist",	
    }
  end

  describe "GET index" do
    before do
      @artist1 = Artist.create! valid_attributes
      @artist2 = Artist.create! valid_attributes
      get :index
    end

    it "should render the index template" do
      expect(response).to render_template :index
    end

    it "should succeed" do
      expect(response).to be_success
    end

    it "should assign artist to all artists" do
      expect(assigns(:artists)).to eq([@artist1, @artist2])
    end
  end

  describe "GET show" do
    before do
      @artist = Artist.create! valid_attributes
      get :show, id: @artist.id
    end

    it "should render the index template" do
      expect(response).to render_template :show
    end

    it "should succeed" do
      expect(response).to be_success
    end

    it "should assign artists to all artists" do
      expect(assigns(:artist)).to eq(@artist)
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

    it "should assign a new artist" do
      expect(assigns(:artist)).to be_a(Artist)
      expect(assigns(:artist)).to_not be_persisted
    end
  end

  describe "GET edit" do
    before do
      @artist = Artist.create! valid_attributes
      get :edit, id: @artist.id
    end

    it "should render the index template" do
      expect(response).to render_template :edit
    end

    it "should succeed" do
      expect(response).to be_success
    end

    it "should assign artist to all artists" do
      expect(assigns(:artist)).to eq(@artist)
    end
  end

  describe "POST create" do
    describe "successful create" do
      it "should save a new Artist to the database" do
        expect do
          post :create, artist: valid_attributes
        end.to change(Artist, :count).by(1)
      end

      it "should redirect to the index action" do
        post :create, artist: valid_attributes
        expect(response).to redirect_to artists_path
      end
    end
    describe "not able to save" do
      let :invalid_attributes do
        {
          :name => nil
        }
      end

      it "should save a new Artist to the database" do
        expect do
          post :create, artist: invalid_attributes
        end.to_not change(Artist, :count).by(1)
      end

      it "should rerender the new template" do
        post :create, artist: invalid_attributes
        expect(response).to render_template :new
      end
    end
  end
end