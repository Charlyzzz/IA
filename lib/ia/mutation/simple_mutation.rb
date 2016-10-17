module IA
  module Mutation

    SIMPLE_MUTATION_RATE = 0.1

    module SimpleMutation
      class << self
        def mutate(train)
          SIMPLE_MUTATION_RATE > rand ? do_mutate(train) : train
        end

        private

        def do_mutate(train)
          chromosome = train.chromosome_string
          position = rand(chromosome.size)
          chromosome[position] = negate(chromosome[position])
          Train.new(chromosome)
        end

        def negate(bit)
          bit.to_i(2).^(1).to_s(2)
        end
      end
    end
  end
end
