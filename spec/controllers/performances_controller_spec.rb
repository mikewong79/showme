require 'spec_helper'

describe PerformancesController do

  let :valid_attributes do
    {
      :date => "04-05-2014",
      :time => "7:00pm",
    }
  end

describe "GET index" do
    before do
      @performance1 = Performance.create! valid_attributes
      @performance2 = Performance.create! valid_attributes
      get :index
    end

    it "should render the index template" do
      expect(response).to render_template :index
    end

    it "should succeed" do
      expect(response).to be_success
    end

    it "should assign performance to all performances" do
      expect(assigns(:performances)).to eq([@performance1, @performance2])
    end
  end

  describe "GET show" do
    before do
      @performance = Performance.create! valid_attributes
      get :show, id: @performance.id
    end

    it "should render the index template" do
      expect(response).to render_template :show
    end

    it "should succeed" do
      expect(response).to be_success
    end

    it "should assign performances to all performances" do
      expect(assigns(:performance)).to eq(@performance)
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

    it "should assign a new performance" do
      expect(assigns(:performance)).to be_a(Performance)
      expect(assigns(:performance)).to_not be_persisted
    end
  end

  describe "GET edit" do
    before do
      @performance = Performance.create! valid_attributes
      get :edit, id: @performance.id
    end

    it "should render the index template" do
      expect(response).to render_template :edit
    end

    it "should succeed" do
      expect(response).to be_success
    end

    it "should assign performances to all performances" do
      expect(assigns(:performance)).to eq(@performance)
    end
  end

  describe "POST create" do
    describe "successful create" do
      it "should save a new Performance to the database" do
        expect do
          post :create, performance: valid_attributes
        end.to change(Performance, :count).by(1)
      end

      it "should redirect to the index action" do
        post :create, performance: valid_attributes
        expect(response).to redirect_to performances_path
      end
    end
    
    describe "not able to save" do
      let :invalid_attributes do
        {
          :flavor => nil
        }
      end

      it "should save a new Performance to the database" do
        expect do
          post :create, performance: invalid_attributes
        end.to_not change(Performance, :count).by(1)
      end

      it "should rerender the new template" do
        post :create, performance: invalid_attributes
        expect(response).to render_template :new
      end
    end
  end
end



