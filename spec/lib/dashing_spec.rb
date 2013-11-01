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

    context 'when block given' do

      it 'yields configuration' do
        Dashing.should_receive(:configure).and_yield(configuration)
        Dashing.configure {|config|}
      end

    end

    context 'when no block given' do

      it 'does nothing' do
        Dashing.configure.should be_nil
      end

    end

  end

  describe '.first_dashboard' do

    let(:dir)   { 'foo' }
    let(:dirs)  { [dir] }

    before do
      Dir.stub(:[]).and_return(dirs)
    end

    it { expect(Dashing.first_dashboard).to eq(dir) }

  end

end
