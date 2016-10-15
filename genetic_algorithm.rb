require_relative 'lib/ia'

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

    # El viajero que se llama igual que el camarero vive en Barcelona.
    condition do
      travelers.any? do |traveler|
        traveler.named?(waiter.name) && traveler.lives_in?(:barcelona)
      end
    end

    restriction do
      passengers.map(&:name).same_elements?(NAMES * 2)
    end

  end
end

puts Array.new(1000000) { IA::Train.new }.map(&:fitness).uniq!.sort