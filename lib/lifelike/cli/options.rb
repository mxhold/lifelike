require 'optparse'
module Lifelike
  module CLI
    class Options
      def self.parse!(argv)
        new.parse!(argv)
      end

      def initialize
        @options = default_options
      end

      def parse!(argv)
        option_parser.parse!(argv)
        @options
      end

      private

      def default_options
        {
          generations: 1,
          rule_string: 'B3/S23'
        }
      end

      # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      def option_parser
        OptionParser.new do |opts|
          opts.banner = 'Usage: lifelike [options] [file]'
          opts.separator 'Options:'

          opts.on(
            '-c [iterations]',
            '--count [iterations]',
            'Number of iterations to perform' \
            "(default #{default_options[:generations]})"
          ) do |c|
            @options[:generations] = c.to_i
          end

          opts.on(
            '-r [rule_string]',
            '--rules [rule_string]',
            'Rules for the life-like cellular automaton ' \
            "(default #{default_options[:rule_string]})"
          ) do |rule_string|
            @options[:rule_string] = rule_string
          end

          opts.on('-h', '--help', 'Prints this message') do
            puts opts
            exit
          end

          opts.on('-v', '--version', 'Prints the version') do
            puts Lifelike::VERSION
            exit
          end
        end
      end
      # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
    end
  end
end
