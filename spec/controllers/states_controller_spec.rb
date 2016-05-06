require 'rails_helper'

RSpec.describe StatesController, type: :controller do
  describe 'GET #index' do
    it 'render all states' do
      state = create(:state)
      get :index
      expect(assigns(:states)).to eq([state])
    end
  end

  describe 'GET #show' do
    it 'render state by id' do
      state = create(:state)
      get :show, id: state.to_param
      expect(assigns(:state)).to eq(state)
    end
  end

  describe 'POST #create' do
    it 'creates a new State' do
      expect do
        post :create, state: FactoryGirl.attributes_for(:state)
      end.to change(State, :count).by(1)
    end
  end
end
