require 'lifelike'
RSpec.describe Lifelike::CLI do
  context 'no arguments' do
    it 'prints the input after a generation' do
      stub_const('ARGV', [])
      allow($stdin).to receive(:read) { "010\n010\n010" }
      allow(Lifelike::CLI).to receive(:exit)
      expect {
        Lifelike::CLI.invoke
      }.to output("000\n111\n000\n").to_stdout
    end
  end

  context 'given 2 as an argument' do
    it 'prints the input after 2 generations' do
      stub_const('ARGV', ['-c', '2'])
      allow($stdin).to receive(:read) { "010\n010\n010" }
      allow(Lifelike::CLI).to receive(:exit)
      expect {
        Lifelike::CLI.invoke
      }.to output("010\n010\n010\n").to_stdout
    end
  end

  context 'alternate rules specified' do
    it 'prints the input after a generation using the alternate rules' do
      stub_const('ARGV', ['-r', 'B2/S'])
      allow($stdin).to receive(:read) { "0000000\n0000000\n0011000\n0000000\n0000000" }
      allow(Lifelike::CLI).to receive(:exit)
      expect {
        Lifelike::CLI.invoke
      }.to output("0000000\n0011000\n0000000\n0011000\n0000000\n").to_stdout
    end
  end

  context 'invalid arguments' do
    it 'prints an error and exits with the appropriate exit code' do
      stub_const('ARGV', ['-dsaf'])
      expect(Lifelike::CLI).to receive(:exit).with(64)
      expect($stderr).to receive(:puts).with(/invalid option/)
      Lifelike::CLI.invoke
    end
  end
end
