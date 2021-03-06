module IA

  # A chromosome of 36 1's means all passengers are randomly generated
  ENV[:INITIAL_TRAIN_CHROMOSOME] = '1' * 36

  class Train
    attr_reader :passengers

    class << self
      attr_reader :statements

      def new(*args)
        super(statements, *args)
      end

      def restriction(&restriction)
        add_statement(restriction => -30)
      end

      def condition(&condition)
        add_statement(condition => 10)
      end

      def statements
        @statements ||= {}
      end

      def add_statement(statement)
        statements.merge!(statement)
      end
    end

    def initialize(statements, sequence = nil)
      @statements = statements
      build_from(sequence || RANDOM_SEQUENCE * 6)
    end

    def chromosome_string
      passengers
          .map { |passenger| passenger.chromosome_string }
          .reduce(:+)
    end

    def fitness
      @statements
          .select { |condition, _| instance_eval(&condition) }
          .inject(100) { |fitness, hash| hash[1] + fitness }
    end

    def driver
      passengers.first
    end

    def waiter
      passengers[1]
    end

    def inspector
      passengers[2]
    end

    def employees
      passengers.take(3)
    end

    def travelers
      passengers.last(3)
    end

    def inspect
      passengers.inspect
    end

    private

    def build_from(chromosome)
      @passengers = chromosome
                        .scan(/.{6}/)
                        .map { |sequence| Passenger.new(sequence) }
    end
  end
end
