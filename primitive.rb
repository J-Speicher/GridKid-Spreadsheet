class IntPrimitive
    
    attr_reader :value
    attr_reader :location 

    def initialize(value,location)
        @value = value
        @location = location
    end

    def evaluate(environment)
        @value.to_i
    end
      
    def to_s
        "#{@value}"
    end
      
end

class FloatPrimitive

    attr_reader :value
    attr_reader :location 

    def initialize(value, location)
        @value = value
        @location = location
    end
    
    def evaluate(environment)
        @value.to_f
    end
    
    def to_s
        "#{@value}"
    end
end

class BoolPrimitive

    attr_reader :value
    attr_reader :location 

    def initialize(value, location)
        @value = value
        @location = location
    end
    
    def evaluate(environment)
        @value
    end

    def to_s
        "#{@value}"
    end
end

class StringPrimitive

    attr_reader :value
    attr_reader :location 

    def initialize(value, location)
        @value = value
        @location = location
    end
    
    
    def evaluate(environment)
        @value
    end

    def to_s
        "#{@value}"
    end
end