class MyFloatToInt

    attr_reader :value
    attr_reader :location 

    def initialize(value,location)
        @value = value
        @location = location
    end

    def evaluate(environment)
		if @value.class == FloatPrimitive
			evalValue = (@value.evaluate(environment)).to_i
			return IntPrimitive.new(evalValue, @location)
		else
            raise "Syntax error: invalid arguments for MyFloatToInt at #{@value.location}"
        end
	end
      
    def to_s
        "MyFloatToInt ( #{@value.to_s}, #{@location} )"
    end
end

class MyIntToFloat

    attr_reader :value
    attr_reader :location 

    def initialize(value,location)
        @value = value
        @location = location
    end

    def evaluate(environment)
		if @value.class == FloatPrimitive
			evalValue = (@value.evaluate(environment)).to_f
			return FloatPrimitive.new(evalValue, @location)
		else
            raise "Syntax error: invalid arguments for MyIntToFloat at #{@value.location}"
        end
	end
      
    def to_s
        "MyIntToFloat ( #{@value.to_s}, #{@location} )"
    end
end