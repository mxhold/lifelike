require_relative '../lib/lifelike/error'
require_relative '../lib/lifelike/lifelike_cellular_automaton/world_string_analyzer'

RSpec.describe Lifelike::LifelikeCellularAutomaton::WorldStringAnalyzer do
  context 'given at least two valid characters' do
    describe 'detecting alive/dead character' do
      matcher :consider do |deadlike|
        match do |subject|
          analyzer = subject.new("#{deadlike}#{@lifelike}")
          analyzer.dead_char == deadlike && analyzer.alive_char == @lifelike
        end

        chain :deader_looking_than, :lifelike
      end

      subject { described_class }

      it { is_expected.to consider(' ').deader_looking_than('_') }
      it { is_expected.to consider('_').deader_looking_than('.') }
      it { is_expected.to consider('.').deader_looking_than(',') }
      it { is_expected.to consider(',').deader_looking_than('o') }
      it { is_expected.to consider('o').deader_looking_than('O') }
      it { is_expected.to consider('O').deader_looking_than('0') }
      it { is_expected.to consider('0').deader_looking_than('1') }
      it { is_expected.to consider('1').deader_looking_than('x') }
      it { is_expected.to consider('x').deader_looking_than('*') }
      it { is_expected.to consider('*').deader_looking_than('X') }
      it { is_expected.to consider('X').deader_looking_than('#') }
      it { is_expected.to consider('#').deader_looking_than('@') }
    end
  end

  context 'given a single valid character' do
    describe 'detecting whether it should be considered alive or dead' do
      matcher :consider do |character|
        match do |subject|
          analyzer = subject.new(character, fallback_dead_char: 'd', fallback_alive_char: 'a')
          fail if %w(d a).include?(character)
          if @consider_dead
            analyzer.dead_char == character
          else
            analyzer.alive_char == character
          end
        end

        chain(:to_be_dead) { @consider_dead = true }
        chain(:to_be_alive) { @consider_dead = false }
      end

      subject { described_class }

      it { is_expected.to consider(' ').to_be_dead }
      it { is_expected.to consider('_').to_be_dead }
      it { is_expected.to consider('.').to_be_dead }
      it { is_expected.to consider(',').to_be_dead }
      it { is_expected.to consider('o').to_be_dead }
      it { is_expected.to consider('O').to_be_dead }
      it { is_expected.to consider('0').to_be_dead }

      it { is_expected.to consider('1').to_be_alive }
      it { is_expected.to consider('x').to_be_alive }
      it { is_expected.to consider('*').to_be_alive }
      it { is_expected.to consider('X').to_be_alive }
      it { is_expected.to consider('#').to_be_alive }
      it { is_expected.to consider('@').to_be_alive }
    end
    describe 'fallback characters' do
      context 'provided char was considered dead' do
        subject { described_class.new(' ') }
        it 'uses "X" as the fallback alive char' do
          expect(subject.alive_char).to eql 'X'
        end
      end
      context 'provided char was considered alive' do
        subject { described_class.new('X') }
        it 'uses " " as the fallback dead char' do
          expect(subject.dead_char).to eql ' '
        end
      end
    end
  end

  context 'given no valid characters' do
    describe '#alive_char' do
      it 'raises a InsufficientValidCharacterError' do
        expect do
          described_class.new('').alive_char
        end.to raise_error(Lifelike::InsufficientValidCharacterError)
      end
    end
    describe '#dead_char' do
      it 'raises a InsufficientValidCharacterError' do
        expect do
          described_class.new('').dead_char
        end.to raise_error(Lifelike::InsufficientValidCharacterError)
      end
    end
  end
end
