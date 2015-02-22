module Lifelike
  class LifelikeCellularAutomaton
    def initialize(rule_string)
      @rules = Rules.new(rule_string)
    end

    def new_world(seed_string)
      World.from_s(seed_string, @rules)
    end
  end
end
