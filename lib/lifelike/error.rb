module Lifelike
  class LifelikeError < StandardError
  end

  class InsufficientValidCharacterError < LifelikeError
    def initialize(valid_characters)
      super("Insufficient characters for determining life/death. Expected two of the following characters: #{valid_characters.map { |c| "\"#{c}\"" }.join(', ') }")
    end
  end

  class UnexpectedCharacterError < LifelikeError
    def initialize(character, expected:)
      super("Unexpected character: \"#{character}\" Expected: #{expected.map { |c| "\"#{c}\"" }.join(' or ')}")
    end
  end

  class UnparsableRuleStringError < LifelikeError
    def initialize(rule_string)
      super("Unparsable rule string: \"#{rule_string}\" Expected something like: \"B3/S23\"")
    end
  end
end
