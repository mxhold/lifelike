require 'lifelike/lifelike_cellular_automaton/rules'
require 'lifelike/lifelike_cellular_automaton/world'
require 'lifelike/lifelike_cellular_automaton/cell'
require 'lifelike/lifelike_cellular_automaton/cell_serializer'
require 'lifelike/lifelike_cellular_automaton/world_serializer'
module Lifelike
  class LifelikeCellularAutomaton
    def initialize(seed_string, rule_string)
      @world_serializer = WorldSerializer.new(seed_string, Rules.new(rule_string))
      @initial_world = @world_serializer.string_to_world(seed_string)
    end

    def tick(generations)
      @world_serializer.world_to_string(@initial_world.tick(generations))
    end
  end
end
