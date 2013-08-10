require 'spec_helper'

describe Dashing::Configuration do

  let(:instance) { Dashing::Configuration.new }

  it { expect(instance).to respond_to(:scheduler) }
  it { expect(instance).to respond_to(:redis) }
  it { expect(instance).to respond_to(:redis_namespace) }
  it { expect(instance).to respond_to(:view_path) }
  it { expect(instance).to respond_to(:jobs_path) }
  it { expect(instance).to respond_to(:engine_path) }
  it { expect(instance).to respond_to(:dashboards_path) }
  it { expect(instance).to respond_to(:dashboard_layout) }
  it { expect(instance).to respond_to(:widgets_path) }
  it { expect(instance).to respond_to(:default_dashboard) }
  it { expect(instance).to respond_to(:auth_token) }

  it { expect(instance).to respond_to(:scheduler=) }
  it { expect(instance).to respond_to(:redis=) }
  it { expect(instance).to respond_to(:redis_namespace=) }
  it { expect(instance).to respond_to(:view_path=) }
  it { expect(instance).to respond_to(:jobs_path=) }
  it { expect(instance).to respond_to(:engine_path=) }
  it { expect(instance).to respond_to(:dashboards_path=) }
  it { expect(instance).to respond_to(:dashboard_layout=) }
  it { expect(instance).to respond_to(:widgets_path=) }
  it { expect(instance).to respond_to(:default_dashboard=) }
  it { expect(instance).to respond_to(:auth_token=) }

  it { expect(instance.scheduler).to          be_a(::Rufus::Scheduler::PlainScheduler) }
  it { expect(instance.redis).to              be_a(::Redis) }
  it { expect(instance.redis_namespace).to    eq('dashing_events') }
  it { expect(instance.view_path).to          eq('app/views/dashing/') }
  it { expect(instance.jobs_path).to          eq('app/jobs/') }
  it { expect(instance.engine_path).to        eq('/dashing') }
  it { expect(instance.dashboards_path).to    eq('app/views/dashing/dashboards/') }
  it { expect(instance.dashboard_layout).to   eq('dashing/dashboard') }
  it { expect(instance.widgets_path).to       eq('app/views/dashing/widgets/') }
  it { expect(instance.default_dashboard).to  be_nil }
  it { expect(instance.auth_token).to         be_nil }

end
