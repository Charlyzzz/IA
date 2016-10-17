require_relative './problem'
require 'csv'

# Para la solución del trabajo práctico usaremos los parámetros especificados abajo.
# Sin embargo, se pueden modificar tranquilamente
#
# Selección = Ruleta
# Cruzamiento = Cruzamiento simple
# Mutación = Mutación simple
# Probabilidad de mutación = 10%
# Punto de pivote del cruzamiento = 5
# Tamaño de la población = 12
# Creación de la población inicial = Aleatoria
# Resultado de la función aptitud máxima = 160

puts 'Starting simulation, please wait.'

results = Array.new(3) do
  solution = IA::GeneticAlgorithm.new.reach_fitness(160)
  puts 'Run finished.'
  solution
end

puts 'All runs have finished.'
puts 'Outputting results.'

results
    .map { |result| result[:metadata] }
    .map { |metadata| metadata.map(&:to_csv).reduce(:+) }
    .each_with_index { |csv, index| File.write("results_run_#{index + 1}.txt", csv) }

content = results.map { |hash| [hash[:winner], hash[:iteration], hash[:last_population]] }.inspect
File.write('results.txt', content)
Dir.entries('.').grep(/.+\.txt/).each { |file| puts "#{file} was created." }
puts 'End of simulation.'
