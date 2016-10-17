require_relative 'lib/ia'
require 'parallel'

module IA
  class Train
    # El viajero Bernardo vive en Madrid.
    condition do
      travelers.any? do |traveler|
        traveler.named?(:bernardo) && traveler.lives_in?(:madrid)
      end
    end

    # El camarero vive a mitad de camino entre Madrid y Barcelona.
    condition { waiter.lives_in? :ciudadIntermedia }

    # Carlos (el viajero) gana dos millones al año.
    condition do
      travelers.any? do |traveler|
        traveler.named?(:carlos) && traveler.earns?(:dosMillones)
      end
    end

    # Uno de los viajeros es vecino del camarero y gana exactamente el triple que él.
    condition do
      travelers.any? do |traveler|
        traveler.lives_in?(waiter.city) &&
            traveler.earns?(:seisMillones) && waiter.earns?(:dosMillones)
      end
    end

    # El empleado de ferrocarriles Alberto, juega a tenis mejor que el revisor del tren.
    condition do
      !inspector.named?(:alberto)
    end

    # El viajero que se llama igual que el camarero vive en Barcelona.
    condition do
      travelers.any? do |traveler|
        traveler.named?(waiter.name) && traveler.lives_in?(:barcelona)
      end
    end

    restriction do
      !passengers.map(&:name).same_elements?(NAMES * 2)
    end
  end
end

# Uso
# La solución óptima tiene 160 de fitness (arranca en 100 y cada una de las seis condiciones suma 10)
# Parallel.map(Array.new(5), in_threads: 5) { |_| IA::GeneticAlgorithm.new.reach_fitness(160) }
#
# El resultado es un hash como el siguiente
# {
#     subject: el ganador,
#     iteration: numero de iteración en la que lo consiguió,
#     populations: lista de todas las poblaciones por las que transitó
# }

