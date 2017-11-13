module ControllerSpecHelpers
  def stub_scheduler(stubbed_scheduler)
    allow(Dashing.config).to receive(:scheduler).and_return(stubbed_scheduler)
  end

  def stub_redis(stubbed_redis)
    allow(Dashing.config).to receive(:redis).and_return(stubbed_redis)
  end

  def stub_redis_with_connection(stubbed_redis, stubbed_redis_connection)
    stub_redis(stubbed_redis)
    allow(stubbed_redis).to receive(:with).and_yield(stubbed_redis_connection)
  end
end
