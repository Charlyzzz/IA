module IA

  ENV[:POPULATION_SIZE] = 12

  class GeneticAlgorithm
    attr_reader :population

    def initialize(selection = Selection::Roulette,
                   crossover = Crossover::SimpleCrossover,
                   mutation = Mutation::SimpleMutation)
      validate
      @selection_method = selection
      @crossover_method = crossover
      @mutation_method = mutation
      @iteration = 0
      @metadata = []
    end

    def iterate(times)
      @condition = proc { @iteration == times }
      evolve
    end

    def reach_fitness(fitness)
      @condition = proc { population.any? { |train| train.fitness == fitness } }
      evolve
    end

    private

    def validate
      raise 'Population size must be an even number' if ENV[:POPULATION_SIZE].odd?
      raise "Population size can't be zero" if ENV[:POPULATION_SIZE].zero?
    end

    def evolve
      @population = Array.new(ENV[:POPULATION_SIZE]) { Train.new }
      parse_metadata
      until @condition.call do
        self.population = @selection_method
                              .sort(population)
                              .each_slice(2)
                              .to_a
                              .flat_map { |train, other_train| @crossover_method.breed(train, other_train) }
                              .map { |train| @mutation_method.mutate(train) }
        @iteration += 1
      end
      { winner: @population.max_by(&:fitness).driver, iteration: @iteration, metadata: @metadata, last_population: population }
    end

    def population=(value)
      @population = value
      parse_metadata
    end

    def parse_metadata
      @metadata << [population.map(&:fitness).max,
                    population.map(&:fitness).min,
                    population
                        .map(&:fitness)
                        .reduce(:+).to_f / population.size]
    end
  end
end
