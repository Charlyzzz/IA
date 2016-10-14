class Genotype
  attr_reader :value

  def initialize(gene, value)
    @gene = gene
    @value = value
  end

  def named?(name)
    @gene.name.to_sym == name
  end

end