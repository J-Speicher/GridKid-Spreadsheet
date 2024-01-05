#assert have boolean operands
class MyLAnd

  attr_reader :location

  def initialize(left, right,location)
    @left = left
    @right = right
    @location = location
  end

  def evaluate(environment)
    # More error checking. Good!
    if @left.is_a?(BoolPrimitive)
      if @right.is_a?(BoolPrimitive)
        evalValue = @left.evaluate(environment) && @right.evaluate(environment)
        return BoolPrimitive.new(evalValue, @location)
      else
        raise "Syntax error: invalid arguments for MyLAnd at #{@right.location}"
      end
    else
      raise "Syntax error: invalid arguments for MyLAnd at #{@left.location}"
    end
  end

  def to_s
    "MyLAnd ( #{@left.to_s} && #{@right.to_s}, #{@location} )"
  end
end

class MyLOr

  attr_reader :location

  def initialize(left, right, location)
    @left = left
    @right = right
    @location = location
  end

  def evaluate(environment)
    if @left.is_a?(BoolPrimitive)
      if @right.is_a?(BoolPrimitive)
        evalValue = @left.evaluate(environment) || @right.evaluate(environment)
        return BoolPrimitive.new(evalValue, @location)
      else
        raise "Syntax error: invalid arguments for MYLOr at #{@right.location}"
      end
    else
      raise "Syntax error: invalid arguments for MYLOr at #{@left.location}"
    end  
  end

  def to_s
    "MYLOr ( #{@left.to_s} || #{@right.to_s}, #{@location} )"
  end
end

class MyLNot
  attr_reader :location

  def initialize(value,location)
    @value = value
    @location = location
  end

  def evaluate(environment)
    if @value.is_a?(BoolPrimitive)
      evalValue = !(@value.evaluate(environment))
      return BoolPrimitive.new(evalValue, @value.location)
    else
      raise "Syntax error: invalid arguments for MyLNot at #{@value.location}"
    end
  end

  def toString
    "MyLNot ( !#{@value.to_s}, #{@location} )"
  end
end