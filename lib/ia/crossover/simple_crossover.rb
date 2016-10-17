module IA
  module Crossover

    SIMPLE_CROSSOVER_POSITION = 18

    module SimpleCrossover
      class << self
        def breed(train, other_train)
          father = train.chromosome_string
          mother = other_train.chromosome_string
          [IA::Train.new(mix(father, mother, at)), IA::Train.new(mix(mother, father, at))]
        end

        private

        def mix(father, mother, at)
          father[0, at] + mother[at..-1]
        end

        def at
          SIMPLE_CROSSOVER_POSITION
        end
      end
    end
  end
end
