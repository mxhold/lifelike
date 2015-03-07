module Lifelike
  class Runner
    def initialize(in_stream, out_stream, rule_string:, generations:)
      @seed = in_stream.read
      @out_stream = out_stream
      @rule_string = rule_string
      @generations = generations
    end

    def run
      @out_stream.puts final_world
    end

    private

    def final_world
      initial_world.tick(@generations)
    end

    def initial_world
      lifelike_cellular_automaton.new_world(@seed)
    end

    def lifelike_cellular_automaton
      LifelikeCellularAutomaton.new(@rule_string)
    end
  end
end
