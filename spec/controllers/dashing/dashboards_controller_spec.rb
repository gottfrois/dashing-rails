RSpec.describe Dashing::DashboardsController do

  before do
    @routes = Dashing::Engine.routes
  end

  describe 'GET "index"' do

    def action
      get :index
    end

    it 'responds success' do
      action
      expect(response).to be_success
    end

  end

  describe 'GET "show"' do

    def action(params = {})
      get :show, params: params
    end

    context 'when template exists' do

      it 'responds success' do
        action(name: 'foo')
        expect(response).to be_success
      end

    end

    context 'when template does not exist' do

      it { expect { action }.to raise_error }
      it { expect { action(name: 'bar') }.to raise_error }

    end

  end

end
