module ControllerSpecHelpers
  def stub_scheduler(stubbed_scheduler)
    allow(Dashing.config).to receive(:scheduler).and_return(stubbed_scheduler)
  end

  def stub_redis(stubbed_redis)
    allow(Dashing.config).to receive(:redis).and_return(stubbed_redis)
  end
end
