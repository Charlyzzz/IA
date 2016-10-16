module IA

  NAMES = [:alberto, :bernardo, :carlos].freeze
  CITIES = [:madrid, :barcelona, :ciudadIntermedia].freeze
  SALARIES = [:dosMillones, :seisMillones].freeze

  RANDOM_SEQUENCE = '111111'

  class Passenger
    attr_reader :chromosomes


    def initialize(chromosomes = nil)
      build_from(chromosomes || RANDOM_SEQUENCE)
    end

    def lives_in?(city)
      self.city == city
    end

    def earns?(salary)
      self.salary == salary
    end

    def named?(name)
      self.name == name
    end

    def salary
      chromosomes.last
    end

    def name
      chromosomes.first
    end

    def city
      chromosomes[1]
    end

    def attributes
      [NAMES, CITIES, SALARIES]
    end

    def chromosome_string
      attributes
          .zip(chromosomes)
          .map { |attribute, chromosome| attribute[chromosome] }
          .map { |value| value.to_binary }
          .reduce(:+)
    end

    private

    def build_from(chromosomes)
      @chromosomes = chromosomes
                         .scan(/.{2}/)
                         .map { |binary_string| binary_string.to_i(2) }
                         .zip(attributes)
                         .map { |position, attribute| attribute[position] || attribute.sample }
    end
  end
end
