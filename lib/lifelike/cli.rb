require 'lifelike/cli/options'
require 'optparse'
module Lifelike
  module CLI
    EX_USAGE = 64
    EX_DATAERR = 65

    def self.invoke
      Runner.new($stdin, $stdout, Options.parse(ARGV)).run
      exit
    rescue OptionParser::ParseError, Lifelike::UnparsableRuleStringError => e
      report_error e
      exit EX_USAGE
    rescue Lifelike::UnexpectedCharacterError => e
      report_error e
      exit EX_DATAERR
    end

    def self.report_error(error)
      $stderr.puts "lifelike: #{error}"
    end
  end
end
