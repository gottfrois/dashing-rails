require 'spec_helper'

describe Dashing::WidgetsController do

  let(:redis) { double }

  before do
    stub_redis(redis)
  end

  describe 'GET "show"' do

    def action(params = {})
      get :show, params.merge(use_route: :dashing)
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
      put :update, params.merge(use_route: :dashing)
    end

    context 'when valid' do

      before do
        expect(redis).to receive(:publish)
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
