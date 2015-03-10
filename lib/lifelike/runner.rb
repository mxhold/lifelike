module Lifelike
  class Runner
    def initialize(in_stream, out_stream, rule_string:, generations:)
      @initial_world_string = in_stream.read
      @out_stream = out_stream
      @rule_string = rule_string
      @generations = generations
    end

    def run
      @out_stream.puts final_world_string
    end

    private

    def final_world_string
      lifelike_cellular_automaton.tick(@generations)
    end

    def lifelike_cellular_automaton
      LifelikeCellularAutomaton.new(@initial_world_string, @rule_string)
    end
  end
end
