module Lifelike
  class LifelikeCellularAutomaton
    class Cell
      def initialize(alive, rules)
        @alive = alive
        @rules = rules
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
        if alive?
          @rules.survives?(alive_neighbor_count)
        else
          @rules.born?(alive_neighbor_count)
        end
      end

      def alive_neighbor_count
        @neighbors.select(&:alive?).size
      end
    end
  end
end
