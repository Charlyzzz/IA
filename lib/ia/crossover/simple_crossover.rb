module IA
  module Crossover
    module SimpleCrossover
      class << self
        def breed(at, train, other_train)
          father = train.chromosome_string
          mother = other_train.chromosome_string
          train.update!(mix(father, mother, at))
          other_train.update!(mix(mother, father, at))
        end

        private

        def mix(father, mother, at)
          father[0, at] + mother[at..-1]
        end
      end
    end
  end
end









