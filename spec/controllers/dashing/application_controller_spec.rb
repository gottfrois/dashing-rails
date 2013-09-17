require 'spec_helper'

describe Dashing::ApplicationController do

  describe '#authentication_with_devise' do

    let(:models) { [:user, :admin] }

    before do
      Dashing.stub_chain(:config, :devise_allowed_models).and_return(models)
    end

    it 'calls devise authenticate method' do
      expect(controller).to receive("authenticate_#{models.first.to_s}!")
      expect(controller).to receive("authenticate_#{models.last.to_s}!")
      controller.send(:authentication_with_devise)
    end

  end

end
