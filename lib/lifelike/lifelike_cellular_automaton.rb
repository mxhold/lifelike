require 'lifelike/lifelike_cellular_automaton/rules'
require 'lifelike/lifelike_cellular_automaton/world'
require 'lifelike/lifelike_cellular_automaton/cell'
require 'lifelike/lifelike_cellular_automaton/cell_serializer'
require 'lifelike/lifelike_cellular_automaton/world_serializer'
require 'lifelike/lifelike_cellular_automaton/world_string_analyzer'
module Lifelike
  class LifelikeCellularAutomaton
    def initialize(initial_world_string, rule_string)
      @initial_world_string = initial_world_string
      @rules = Rules.new(rule_string)
    end

    def tick(generations)
      world_serializer.dump(initial_world.tick(generations))
    end

    private

    def initial_world
      world_serializer.load(@initial_world_string)
    end

    def world_serializer
      @world_serializer ||= WorldSerializer.new(cell_serializer)
    end

    def cell_serializer
      CellSerializer.new(
        alive_char: alive_char,
        dead_char: dead_char,
        rules: @rules
      )
    end

    def alive_char
      world_string_analyzer.alive_char
    end

    def dead_char
      world_string_analyzer.dead_char
    end

    def world_string_analyzer
      @analyzer ||= WorldStringAnalyzer.new(@initial_world_string)
    end
  end
end
