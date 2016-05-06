require 'rails_helper'

RSpec.describe BugsController, type: :controller do
  let(:bug) { create(:bug) }

  describe 'GET #index' do
    it 'render all bugs' do
      bug = create(:bug)
      get :index
      expect(assigns(:bugs)).to eq([bug])
    end

    it 'render status code 200 ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'order bugs by priority' do
      critical_bug = create(:bug, priority: :critical)
      minor_bug = create(:bug, priority: :minor)
      major_bug = create(:bug, priority: :major)

      get :index
      expect(assigns(:bugs)).to eq([critical_bug, major_bug, minor_bug])
    end
  end

  describe 'GET #show' do
    context 'when bug found' do

      before(:each) do
        request.headers['token'] = bug.application_token
      end

      it 'render bug by number' do
        get :show, number: bug.number
        expect(assigns(:bug)).to eq(bug)
      end

      it 'render status code 200 ok' do
        get :show, number: bug.number
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when bug not found' do
      context 'with invalid bug number' do
        before(:each) do
          request.headers['token'] = bug.application_token
        end

        it 'render status code 404 not found' do
          get :show, number: 'notfoundnumber'
          expect(response).to have_http_status(404)
        end

        it 'render bug not found error msg' do
          get :show, number: 'notfoundnumber'
          expect(JSON.parse(response.body)['error']).to eq('bug not found')
        end
      end

      context 'with invalid token' do
        it 'render status code 404 not found' do
          get :show, number: bug.number
          expect(response).to have_http_status(404)
        end

        it 'render bug not found error msg' do
          get :show, number: bug.number
          expect(JSON.parse(response.body)['error']).to eq('bug not found')
        end
      end
    end
  end

  describe 'GET #count' do
    let(:bug) { create(:bug, application_token: 1) }

    context 'when application is found' do
      before(:each) do
        request.headers['token'] = bug.application_token
      end

      it 'render status code 200 ok' do
        get :count
        expect(response).to have_http_status(:ok)
      end

      it 'render hash with application_token and bugs count' do
        get :count
        expect(response).to match_response_schema('application_count')
      end
    end

    context 'when application not found' do
      it 'render 404 status code wiht msg not found' do
        get :count
        expect(response).to have_http_status(404)
      end

      it 'render application not found error msg' do
        get :count
        expect(JSON.parse(response.body)['error']).to eq('application not found')
      end
    end
  end

  describe 'POST #create' do
    let(:bug) { create(:bug, application_token: 1) }
    before(:each) do
      request.headers['token'] = bug.application_token
    end

    context 'with valid params' do
      it 'render 201 created status code' do
        post :create, bug: FactoryGirl.attributes_for(:bug)
        expect(response).to have_http_status(:created)
      end

      it 'save the new bug to database' do
        expect do
          post :create, bug: FactoryGirl.attributes_for(:bug)
        end.to change(Bug, :count)
      end
    end

    context 'with invalid params' do
      it 'render 422 unprocessable entity status code' do
        post :create, bug: FactoryGirl.attributes_for(:bug, application_token: '')
        expect(response).to have_http_status(422)
      end

      it 'should not save the bug to database' do
        expect do
          post :create, bug: FactoryGirl.attributes_for(:bug, application_token: '')
        end.to_not change(Bug, :count)
      end

      it 'render key :error with error massages' do
        post :create, bug: FactoryGirl.attributes_for(:bug, application_token: '')
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.keys).to contain_exactly("error")
      end
    end
  end
end
