module IA

  POPULATION_SIZE = 10

  class GeneticAlgorithm
    attr_reader :populations

    def initialize(selection = Selection::Roulette,
                   crossover = Crossover::SimpleCrossover,
                   mutation = Mutation::SimpleMutation)
      validate
      @selection_method = selection
      @crossover_method = crossover
      @mutation_method = mutation
      @iteration = 0
      @populations = []
    end

    def iterate(times)
      @condition = proc { @iteration == times }
      evolve
    end

    def reach_fitness(fitness)
      @condition = proc { actual_population.any? { |train| train.fitness == fitness } }
      evolve
    end

    private

    def validate
      raise 'Population size must be an even number' if POPULATION_SIZE.odd?
      raise "Population size can't be zero" if POPULATION_SIZE.zero?
    end

    def evolve
      populations << Array.new(POPULATION_SIZE) { Train.new }
      until @condition.call do
        populations << @selection_method
                           .sort(actual_population)
                           .each_slice(2)
                           .to_a
                           .flat_map { |train, other_train| @crossover_method.breed(train, other_train) }
                           .map { |train| @mutation_method.mutate(train) }
        @iteration += 1
      end
      { subject: actual_population.max_by(&:fitness), iteration: @iteration, populations: populations }
    end

    def actual_population
      populations.last
    end
  end
end
