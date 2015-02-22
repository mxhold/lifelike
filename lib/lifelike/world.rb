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
      if generations == 1
        tick_once
      else
        tick_once.tick(generations - 1)
      end
    end

    def to_s
      @grid.to_s do |cell|
        cell.to_s
      end
    end

    private

    def tick_once
      self.class.new(
        @grid.map_with_neighbors do |cell, neighbors|
          cell.tick(neighbors)
        end
      )
    end
  end
end
