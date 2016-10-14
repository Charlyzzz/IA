module IA
  class Gene
    attr_reader :name

    def initialize(name, values, type)
      @name = name
      @values = values
      @type = type
    end

    def primary?
      @type.eql? :primary
    end

    def sample
      Genotype.new(self, @values.sample)
    end
  end
end