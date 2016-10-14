module IA
  class Individual
    class << self
      def gene(name, values, type = :secondary)
        raise 'This gene has no values!' if values.empty?
        add_gene(Gene.new(name, values, type))
      end

      def population(size: 10)
        raise 'No primary gene given' if genes.none? &:primary?
        Array.new(size) { sample }
      end

      private

      def add_gene(gene)
        genes << gene
      end

      def genes
        @genes ||= []
      end

      def sample
        new(genes.map &:sample)
      end
    end

    def initialize(genotypes)
      @genotypes = genotypes
    end

    def method_missing(symbol, *args)
      if genotype?(symbol)
        genotype_value(symbol)
      else
        super
      end
    end

    private

    def genotype?(name)
      !!genotype_named(name)
    end

    def genotype_named(name)
      @genotypes.find { |genotype| genotype.named? name }
    end

    def genotype_value(name)
      genotype_named(name).value
    end

  end
end