RSpec.describe Dashing do

  it { expect(Dashing).to respond_to :configuration }

  describe '.config' do

    it { expect(Dashing.config).to be_a(Dashing::Configuration) }

  end

  describe '.configure' do

    let(:configuration) { Dashing::Configuration.new }

    before do
      allow(Dashing).to receive(:config).and_return(:configuration)
    end

    context 'when block given' do

      it 'yields configuration' do
        expect(Dashing).to receive(:configure).and_yield(configuration)
        Dashing.configure {|config|}
      end

    end

    context 'when no block given' do

      it { expect(Dashing.configure).to be_nil }

    end

  end

  describe '.first_dashboard' do

    let(:dir)   { 'foo' }
    let(:dirs)  { [dir] }

    before do
      allow(Dir).to receive(:[]).and_return(dirs)
    end

    it { expect(Dashing.first_dashboard).to eq(dir) }

  end

end
