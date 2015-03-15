require 'lifelike'
require 'lifelike/cli'
RSpec.describe Lifelike::CLI, :integration do
  context 'no arguments' do
    it 'prints the input after a generation' do
      stub_const('ARGV', [])
      allow(ARGF).to receive(:read) { "010\n010\n010" }
      allow(Lifelike::CLI).to receive(:exit)
      expect {
        Lifelike::CLI.invoke
      }.to output("000\n111\n000\n").to_stdout
    end
  end

  context 'given 2 as an argument' do
    it 'prints the input after 2 generations' do
      stub_const('ARGV', ['-c', '2'])
      allow(ARGF).to receive(:read) { "010\n010\n010" }
      allow(Lifelike::CLI).to receive(:exit)
      expect {
        Lifelike::CLI.invoke
      }.to output("010\n010\n010\n").to_stdout
    end
  end

  context 'alternate rules specified' do
    it 'prints the input after a generation using the alternate rules' do
      stub_const('ARGV', ['-r', 'B2/S'])
      allow(ARGF).to receive(:read) { "0000000\n0000000\n0011000\n0000000\n0000000" }
      allow(Lifelike::CLI).to receive(:exit)
      expect {
        Lifelike::CLI.invoke
      }.to output("0000000\n0011000\n0000000\n0011000\n0000000\n").to_stdout
    end
  end

  context 'alternate live/dead characters' do
    it 'prints the output with the same characters' do
      stub_const('ARGV', [])
      allow(ARGF).to receive(:read) { ".o.\n.o.\n.o." }
      allow(Lifelike::CLI).to receive(:exit)
      expect {
        Lifelike::CLI.invoke
      }.to output("...\nooo\n...\n").to_stdout
    end
  end

  context 'invalid arguments' do
    it 'prints an error and exits with the appropriate exit code' do
      stub_const('ARGV', ['-dsaf'])
      expect(Lifelike::CLI).to receive(:exit).with(64)
      expect {
        Lifelike::CLI.invoke
      }.to output(/invalid option/).to_stderr
    end
  end

  context 'unparsable rule string' do
    it 'prints an error and exits with the appropriate exit code' do
      stub_const('ARGV', ['-r', 'QWSD'])
      allow(ARGF).to receive(:read) { "o.o" }
      expect(Lifelike::CLI).to receive(:exit).with(64)
      expect {
        Lifelike::CLI.invoke
      }.to output(/unparsable rule string/i).to_stderr
    end
  end

  context 'insufficient valid characters' do
    it 'raises an error and exits with the appropriate exit code' do
      stub_const('ARGV', [])
      allow(ARGF).to receive(:read) { "wyr" }
      allow(Lifelike::CLI).to receive(:exit).with(65)
      expect {
        Lifelike::CLI.invoke
      }.to output(/insufficient characters/i).to_stderr
    end
  end

  context 'unexpected character' do
    it 'raises an error and exits with the appropriate exit code' do
      stub_const('ARGV', [])
      allow(ARGF).to receive(:read) { "o.o.W" }
      allow(Lifelike::CLI).to receive(:exit).with(65)
      expect {
        Lifelike::CLI.invoke
      }.to output(/unexpected character/i).to_stderr
    end
  end
end
