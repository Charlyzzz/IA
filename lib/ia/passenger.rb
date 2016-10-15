module IA
  class Passenger

    def initialize
      @chromosomes = [NAMES.sample, CITIES.sample, SALARIES.sample]
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
  end
end