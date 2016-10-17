module IA
  module Ranking
    class << self
      def sort(population)
        population.sort_by { |train| train.fitness }
      end
    end
  end
end