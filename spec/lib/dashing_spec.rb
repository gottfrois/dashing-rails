require 'spec_helper'

describe Dashing do

  it { expect(Dashing).to respond_to :configuration }

  describe '.config' do

    it { expect(Dashing.config).to be_a(Dashing::Configuration) }

  end

  describe '.configure' do

    let(:configuration) { Dashing::Configuration.new }

    before do
      Dashing.stub(:config).and_return(:configuration)
    end

    it 'yields configuration' do
      Dashing.should_receive(:configure).and_yield(configuration)
      Dashing.configure {|config|}
    end

  end

end
