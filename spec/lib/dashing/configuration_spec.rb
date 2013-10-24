require 'spec_helper'

describe Dashing::Configuration do

  let(:instance) { Dashing::Configuration.new }

  it { expect(instance.scheduler).to              be_a(::Rufus::Scheduler) }
  it { expect(instance.redis_host).to             eq('127.0.0.1') }
  it { expect(instance.redis_port).to             eq('6379') }
  it { expect(instance.redis_password).to         be_nil }
  it { expect(instance.redis_namespace).to        eq('dashing_events') }
  it { expect(instance.view_path).to              eq('app/views/dashing/') }
  it { expect(instance.jobs_path).to              eq('app/jobs/') }
  it { expect(instance.engine_path).to            eq('/dashing') }
  it { expect(instance.dashboards_path).to        eq('app/views/dashing/dashboards/') }
  it { expect(instance.dashboard_layout).to       eq('dashing/dashboard') }
  it { expect(instance.widgets_path).to           eq('app/views/dashing/widgets/') }
  it { expect(instance.default_dashboard).to      be_nil }
  it { expect(instance.auth_token).to             be_nil }
  it { expect(instance.devise_allowed_models).to  be_empty }

  it { expect(instance.redis).to                  be_a(::Redis) }

  describe '#request_thread_count' do

    context 'when puma respond to cli_config' do

      let(:value) { 2 }

      before do
        Object.const_set('Puma', Class.new)
        ::Puma.stub_chain(:cli_config, :options).and_return(max_threads: value)
      end

      after do
        Object.send(:remove_const, 'Puma') if defined?(Puma)
      end

      it { expect(instance.send(:request_thread_count)).to eq(value) }

    end

    context 'by default' do

      it { expect(instance.send(:request_thread_count)).to eq(5) }

    end

  end

end
