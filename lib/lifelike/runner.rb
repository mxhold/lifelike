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
      LifelikeCellularAutomaton.new(@seed, @rule_string).tick(@generations)
    end
  end
end
