require 'lifelike/cli/options'
module Lifelike
  module CLI
    # Conventional exit codes from BSD's sysexits.h
    # See: https://www.freebsd.org/cgi/man.cgi?query=sysexits
    EX_USAGE = 64 # Command was used incorrectly
    EX_DATAERR = 65 # Input data was incorrect

    def self.invoke
      options = Options.parse!(ARGV)
      puts Runner.new(ARGF.read, options).run
      exit
    rescue OptionParser::ParseError, Lifelike::UnparsableRuleStringError => e
      report_error e
      exit EX_USAGE
    rescue Lifelike::UnexpectedCharacterError, Lifelike::InsufficientValidCharacterError => e
      report_error e
      exit EX_DATAERR
    end

    def self.report_error(error)
      $stderr.puts "lifelike: #{error}"
    end
  end
end
