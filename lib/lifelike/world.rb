module Lifelike
  class World
    def initialize(grid)
      @grid = grid
    end

    def self.from_s(string, rules)
      new(
        Grid.from_s(string) do |char|
          Cell.from_s(char, rules)
        end
      )
    end

    def tick(generations)
      (1..generations).reduce(self) do |world, _|
        world.tick_once
      end
    end

    def to_s
      @grid.to_s do |cell|
        cell.to_s
      end
    end

    def tick_once
      self.class.new(
        @grid.map_with_neighbors do |cell, neighbors|
          cell.tick(neighbors)
        end
      )
    end
  end
end
