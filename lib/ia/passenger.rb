module IA
  class Passenger
    attr_reader :chromosomes

    def initialize
      @chromosomes = attributes.map { |attribute| attribute.sample }
    end

    def update!(chromosomes)
      @chromosomes = chromosomes
                         .scan(/.{2}/)
                         .map { |binary_string| binary_string.to_i(2) }
                         .zip(attributes)
                         .map { |position, attribute| attribute[position] }
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
      [IA::NAMES, IA::CITIES, IA::SALARIES]
    end

    def chromosome_string
      attributes
          .zip(chromosomes)
          .map { |attribute, chromosome| attribute[chromosome] }
          .map { |value| value.to_binary }
    end
  end
end
