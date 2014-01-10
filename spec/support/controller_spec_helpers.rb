module ControllerSpecHelpers
  def stub_scheduler(stubbed_scheduler)
    Dashing.config.stub(:scheduler).and_return(stubbed_scheduler)
  end

  def stub_messenger(stubbed_messenger)
    Dashing.config.stub(:messenger).and_return(stubbed_messenger)
  end
end
