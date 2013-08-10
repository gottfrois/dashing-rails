require 'spec_helper'

describe Dashing::DashboardsController do

  describe 'GET "index"' do

    def action
      get :index, use_route: :dashing
    end

    it 'responds success' do
      action
      expect(response).to be_success
    end

  end

  describe 'GET "show"' do

    def action(params = {})
      get :show, params.merge(use_route: :dashing)
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
