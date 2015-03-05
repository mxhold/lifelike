module Lifelike
  class Rules
    # See: http://www.conwaylife.com/wiki/Rule#Rules
    # Example: B3/S23
    def initialize(rule_string)
      @rule_string = rule_string
    end

    def survives?(alive_neighbor_count)
      alive_neighbors_to_survive.include?(alive_neighbor_count)
    end

    def born?(alive_neighbor_count)
      alive_neighbors_to_be_born.include?(alive_neighbor_count)
    end

    private

    def alive_neighbors_to_be_born
      parse_rule_part('B')
    end

    def alive_neighbors_to_survive
      parse_rule_part('S')
    end

    def parse_rule_part(letter)
      numbers_after_letter(@rule_string, letter)
    end

    def numbers_after_letter(string, letter)
      string[/#{letter}(\d*)/, 1].split('').map(&:to_i)
    end
  end
end
