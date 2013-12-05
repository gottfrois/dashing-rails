module ControllerSpecHelpers
  def stub_scheduler(stubbed_scheduler)
    Dashing.config.stub(:scheduler).and_return(stubbed_scheduler)
  end

  def stub_redis(stubbed_redis)
    Dashing.config.stub(:redis).and_return(stubbed_redis)
  end
end
