require 'lifelike/cli/options'
RSpec.describe Lifelike::CLI::Options do
  describe '.parse' do
    it 'has defaults' do
      expect(described_class.parse!([])).to eql(generations: 1, rule_string: 'B3/S23')
    end

    it 'sets the generations' do
      expect(described_class.parse!(["-c", "1"])).to include(generations: 1)
      expect(described_class.parse!(["--count", "1"])).to include(generations: 1)
    end

    it 'sets the rule_string' do
      expect(described_class.parse!(['-r', 'B2/S3'])).to include(rule_string: 'B2/S3')
      expect(described_class.parse!(['--rule', 'B2/S3'])).to include(rule_string: 'B2/S3')
    end

    it 'displays the help with -h' do
      allow_any_instance_of(described_class).to receive(:exit)
      expect do
        described_class.parse!(['-h'])
      end.to output(/Usage/).to_stdout
      expect do
        described_class.parse!(['--help'])
      end.to output(/Usage/).to_stdout
    end

    it 'displays the version with -v' do
      allow_any_instance_of(described_class).to receive(:exit)
      stub_const('Lifelike::VERSION', '1.2.3')
      expect do
        described_class.parse!(['-v'])
      end.to output("1.2.3\n").to_stdout
      expect do
        described_class.parse!(['--version'])
      end.to output("1.2.3\n").to_stdout
    end

    it 'raises an exception on unknown options' do
      expect do
        described_class.parse!(['-z'])
      end.to raise_exception(OptionParser::InvalidOption)
    end
  end
end
