require 'spec_helper'

describe Dashing::Configuration do

  let(:instance) { Dashing::Configuration.new }

  it { expect(instance.engine_path).to            eq('/dashing') }
  # it { expect(instance.scheduler).to              be_a(::Rufus::Scheduler.new) }
  it { expect(instance.redis).to                  be_a(::Redis) }

  # Redis
  it { expect(instance.redis_host).to             eq('127.0.0.1') }
  it { expect(instance.redis_port).to             eq('6379') }
  it { expect(instance.redis_password).to         be_nil }
  it { expect(instance.redis_timeout).to          eq(3) }
  it { expect(instance.redis_namespace).to        eq('dashing_events') }

  # Authorization
  it { expect(instance.auth_token).to             be_nil }
  it { expect(instance.devise_allowed_models).to  be_empty }

  # Jobs
  it { expect(instance.jobs_path.call.to_s).to    include('app/jobs') }

  # Dashboards
  it { expect(instance.default_dashboard).to      be_nil }
  it { expect(instance.dashboards_views_path.call.to_s).to include('app/views/dashing/dashboards') }
  it { expect(instance.dashboard_layout_path).to  eq('dashing/dashboard') }

  # Widgets
  it { expect(instance.widgets_views_path.to_s).to include('app/views/dashing/widgets') }
  it { expect(instance.widgets_js_path.to_s).to    include('app/assets/javascripts/dashing') }
  it { expect(instance.widgets_css_path.to_s).to   include('app/assets/stylesheets/dashing') }

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
