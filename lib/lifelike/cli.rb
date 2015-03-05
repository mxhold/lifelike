require 'lifelike/cli/options'
require 'optparse'
module Lifelike
  module CLI
    EX_USAGE = 64

    def self.invoke
      Runner.new($stdin, $stdout, Options.parse(ARGV)).run
      exit
    rescue OptionParser::InvalidOption => e
      report_error e
      exit EX_USAGE
    end

    def self.report_error(error)
      $stderr.puts "lifelike: #{error}"
    end
  end
end
