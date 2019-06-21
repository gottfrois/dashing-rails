RSpec.describe Dashing::WidgetsController do

  let(:redis) { double }
  let(:redis_connection) { double }

  before do
    stub_redis_with_connection(redis, redis_connection)
    @routes = Dashing::Engine.routes
  end

  describe 'GET "show"' do

    def action(params = {})
      get :show, params: params
    end

    context 'when default template exists' do

      it 'responds success' do
        action(name: 'text')
        expect(response).to be_success
      end

    end

    context 'when template exists in main app' do

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

  describe 'PUT "update"' do

    def action(params = {})
      put :update, params: params
    end

    context 'when valid' do

      before do
        expect(redis_connection).to receive(:publish)
      end

      it 'responds success' do
        action(name: 'foo')
        expect(response).to be_success
      end

    end

    context 'when not valid' do

      it { expect { action }.to raise_error }

    end

  end

end
