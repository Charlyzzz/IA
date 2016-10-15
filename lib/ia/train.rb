module IA
  class Train
    attr_reader :passengers

    class << self
      attr_reader :conditions

      def new(*_)
        super(conditions, restrictions)
      end

      def restriction(&restriction)
        restrictions << restriction
      end

      def condition(&condition)
        conditions << condition
      end

      def conditions
        @conditions ||= []
      end

      def restrictions
        @restrictions ||= []
      end
    end

    def fitness
      @conditions.count { |condition| instance_eval(&condition) } * 10 -
          @restrictions.count { |condition| instance_eval(&condition) } * 30
    end

    def initialize(conditions, restrictions)
      @conditions = conditions
      @restrictions = restrictions
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