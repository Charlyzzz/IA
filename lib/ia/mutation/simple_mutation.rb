module IA
  module Mutation

    MUTATION_RATE = 1

    module SimpleMutation
      class << self
        def mutate(train)
          MUTATION_RATE > rand ? do_mutate(train) : train
        end

        private

        def do_mutate(train)
          chromosome = train.chromosome_string
          position = rand(chromosome.size)
          chromosome[position] = negate(chromosome[position])
          train.update!(chromosome)
        end

        def negate(bit)
          bit.to_i(2).^(1).to_s(2)
        end
      end
    end
  end
end