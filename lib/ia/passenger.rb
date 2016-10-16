module IA
  class Passenger

    def initialize
      @chromosomes = attributes.map { |attribute| attribute.sample }
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
      @chromosomes.last
    end

    def name
      @chromosomes.first
    end

    def city
      @chromosomes[1]
    end

    def attributes
      [NAMES, CITIES, SALARIES]
    end

    def chromosome_string
      attributes
          .zip(@chromosomes)
          .map { |attribute, chromosome| attribute[chromosome] }
          .map { |value| value.to_binary }
    end
  end
end