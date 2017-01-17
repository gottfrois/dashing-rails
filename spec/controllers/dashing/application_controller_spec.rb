RSpec.describe Dashing::ApplicationController do

  describe '#authentication_with_devise' do

    let(:models) { [:user, :admin] }
    let!(:devise_instances) do
      module DeviseInstances
        def authenticate_user!; end
        def authenticate_admin!; end
      end
    end

    before do
      controller.extend(DeviseInstances)
      allow(Dashing).to receive_message_chain(:config, :devise_allowed_models).and_return(models)
    end

    it 'calls devise authenticate method' do
      expect(controller).to receive("authenticate_user!")
      expect(controller).to receive("authenticate_admin!")
      controller.send(:authentication_with_devise)
    end

  end

end
