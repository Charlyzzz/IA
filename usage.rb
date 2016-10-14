require_relative 'lib/ia'

class Card < IA::Individual
  gene 'numero', [1, 2, 3, 4, 5], :primary
  gene 'palo', [:basto, :oro, :espada, :copa]

  def fitness
    palo
  end
end

population = Card.population(size: 10)

population.each { |card| puts card.fitness }

