module Lifelike
  class Cell
    ALIVE = '1'
    DEAD = '0'

    def self.from_s(char, rules)
      new(char == ALIVE, rules)
    end

    def initialize(alive, rules)
      @alive = alive
      @rules = rules
    end

    def to_s
      alive? ? ALIVE : DEAD
    end

    def alive?
      @alive
    end

    def tick(neighbors)
      @neighbors = neighbors
      self.class.new(alive_next?, @rules)
    end

    private

    def alive_next?
      @rules.alive_next?(alive?, alive_neighbor_count)
    end

    def alive_neighbor_count
      @neighbors.select(&:alive?).size
    end
  end
end
