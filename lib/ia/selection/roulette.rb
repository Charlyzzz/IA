module IA
  module Selection
    class Roulette
      def self.sort(population)
        new(population).sort
      end

      def initialize(population)
        @population = population
      end

      def sort
        random_numbers
            .map { |random| selection.find { |_, chance| chance >= random } }
            .map(&:first)
      end

      private

      def selection
        @population.zip(cumulative_probabilities)
      end

      def random_numbers
        @random_numbers ||= Array.new(@population.size) { rand }
      end

      def probabilities
        @probabilities ||= @population.map { |train| train.fitness / total_fitness.to_f }
      end

      def total_fitness
        @total_fitness ||= @population.inject(0) { |fitness, train| train.fitness + fitness }
      end

      def cumulative_probabilities
        @cumulative_probabilities ||= probabilities.map.with_index do |probability, index|
          case index
            when 0
              probability
            else
              probabilities.take(index + 1).reduce(:+)
          end
        end
      end
    end
  end
end