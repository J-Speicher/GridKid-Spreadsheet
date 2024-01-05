class MyEquals
    attr_reader :location
    
    def initialize(left, right, location)
        @left = left
        @right = right
        @location = location
    end
    
    def evaluate(environment)
        if @left.class == IntPrimitive || @left.class == FloatPrimitive || 
            @left.class == BoolPrimitive || @left.class == StringPrimitive
            if @left.class == @right.class
                evalValue = @left.evaluate(environment) == @right.evaluate(environment)
                return @left.class.new(evalValue, @location)
            else
                raise "Syntax error: invalid arguments for MyEquals at #{@right.location}"
            end
        else
            raise "Syntax error: invalid arguments for MyEquals at #{@left.location}"
        end
    end

    def to_s
        "MyEquals ( #{@left.to_s} == #{@right.to_s}, #{@location} )"
    end
end

class MyNotEquals
    attr_reader :location

    def initialize(left, right, location)
        @left = left
        @right = right
        @location = location
    end
    
    def evaluate(environment)
        if @left.class == IntPrimitive || @left.class == FloatPrimitive || 
            @left.class == BoolPrimitive || @left.class == StringPrimitive
            if @left.class == @right.class
                evalValue = @left.evaluate(environment) != @right.evaluate(environment)
                return @left.class.new(evalValue, @location)
            else
                raise "Syntax error: invalid arguments for MyNotEquals at #{@right.location}"
            end
        else
            raise "Syntax error: invalid arguments for MyNotEquals at #{@left.location}"
        end
    end

    def to_s
        "MyNotEquals ( #{@left.to_s} != #{@right.to_s}, #{@location} )"
    end
end

class MyLessThan
    attr_reader :location

    def initialize(left, right, location)
        @left = left
        @right = right
        @location = location
    end
    
    def evaluate(environment)
        if @left.class == IntPrimitive || @left.class == FloatPrimitive
            if @right.class == IntPrimitive || @right.class == FloatPrimitive
                evalValue = @left.evaluate(environment) < @right.evaluate(environment)
                return @left.class.new(evalValue, @location)
            else
                raise "Syntax error: invalid arguments for MyLessThan at #{@right.location}"
            end
        else
            raise "Syntax error: invalid arguments for MyLessThan at #{@left.location}"
        end
    end

    def to_s
        "MyLessThan ( #{@left.to_s} < #{@right.to_s}, #{@location} )"
    end
end

class MyGreaterThan
    attr_reader :location

    def initialize(left, right, location)
        @left = left
        @right = right
        @location = location
    end
    
    def evaluate(environment)
        if @left.class == IntPrimitive || @left.class == FloatPrimitive
            if @right.class == IntPrimitive || @right.class == FloatPrimitive
                evalValue = @left.evaluate(environment) > @right.evaluate(environment)
                return @left.class.new(evalValue, @location)
            else
                raise "Syntax error: invalid arguments for MyGreaterThan at #{@right.location}"
            end
        else
            raise "Syntax error: invalid arguments for MyGreaterThan at #{@left.location}"
        end
    end

    def to_s
        "MyGreaterThan ( #{@left.to_s} > #{@right.to_s}, #{@location} )"
    end
end

class MyLessThanOrEqual
    attr_reader :location

    def initialize(left, right, location)
        @left = left
        @right = right
        @location = location
    end
    
    def evaluate(environment)
        if @left.class == IntPrimitive || @left.class == FloatPrimitive
            if @right.class == IntPrimitive || @right.class == FloatPrimitive
                evalValue = @left.evaluate(environment) <= @right.evaluate(environment)
                return @left.class.new(evalValue, @location)
            else
                raise "Syntax error: invalid arguments for MyLessThanOrEqual at #{@right.location}"
            end
        else
            raise "Syntax error: invalid arguments for MyLessThanOrEqual at #{@left.location}"
        end
    end

    def to_s
        "MyLessThanOrEqual ( #{@left.to_s} <= #{@right.to_s}, #{@location} )"
    end
end

class MyGreaterThanOrEqual
    attr_reader :location

    def initialize(left, right, location)
        @left = left
        @right = right
        @location = location
    end
    
    def evaluate(environment)
        if @left.class == IntPrimitive || @left.class == FloatPrimitive
            if @right.class == IntPrimitive || @right.class == FloatPrimitive
                evalValue = @left.evaluate(environment) >= @right.evaluate(environment)
                return @left.class.new(evalValue, @location)
            else
                raise "Syntax error: invalid arguments for MyGreaterThanOrEqual at #{@right.location}"
            end
        else
            raise "Syntax error: invalid arguments for MyGreaterThanOrEqual at #{@left.location}"
        end
    end

    def to_s
        "MyGreaterThanOrEqual ( #{@left.to_s} >= #{@right.to_s}, #{@location} )"
    end
end