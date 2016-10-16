module IA
  class Train
    attr_reader :passengers

    class << self
      attr_reader :statements

      def new(*_)
        super(statements)
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

    def fitness
      @statements
          .select { |condition, _| instance_eval(&condition) }
          .inject(0) { |fitness, hash| hash[1] + fitness }
    end

    def initialize(statements)
      @statements = statements
      @passengers = Array.new(6) { Passenger.new }
    end

    def driver
      @passengers.first
    end

    def waiter
      @passengers[1]
    end

    def inspector
      @passengers.first
    end

    def travelers
      @passengers.last(3)
    end

  end
end