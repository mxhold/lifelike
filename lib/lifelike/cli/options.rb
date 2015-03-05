module Lifelike
  module CLI
    class Options
      def default_options
        {
          generations: 1,
          rules: 'B3/S23',
        }
      end

      def self.parse(argv)
        new.parse(argv)
      end

      def initialize
        @options = default_options
      end

      def parse(argv)
        option_parser.parse(argv)
        options
      end

      private

      attr_reader :options

      def option_parser
        OptionParser.new do |opts|
          opts.banner = 'Usage: lifelike [options]'
          opts.separator "Options:"

          opts.on(
            '-c [iterations]',
            '--count [iterations]',
            'Number of iterations to perform'\
            "(default #{default_options[:generations]})"
          ) do |c|
            options[:generations] = c.to_i
          end

          opts.on(
            '-r [rule_string]',
            '--rules [rule_string]',
            "Rules for the life-like cellular automaton (default #{default_options[:rules]})"
          ) do |r|
            options[:rules] = r
          end

          opts.on('-h', '--help', 'Prints this message') do |r|
            puts opts
            exit
          end

          opts.on('-v', '--version', 'Prints the version') do |r|
            puts Lifelike::VERSION
            exit
          end
        end
      end
    end
  end
end
