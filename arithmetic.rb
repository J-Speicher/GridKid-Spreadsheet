#assert numeric operands that are compatible in eval
class MyAdd

	attr_reader :left
	attr_reader :right
    attr_reader :location 

    def initialize(left,right,location)
        @left = left
		@right = right
		@location = location
	end

	def evaluate(environment)
		if @left.class == IntPrimitive || @left.class == FloatPrimitive
			if @left.class == @right.class	
				evalValue = @left.evaluate(environment) + @right.evaluate(environment)
				return @left.class.new(evalValue, @location)
			else
				raise "Syntax error: invalid arguments for MyAdd at #{@right.location}"
			end
		else
			raise "Syntax error: invalid arguments for MyAdd at #{@left.location}"
		end
	end

	def to_s
		"MyAdd ( #{@left.to_s} + #{@right.to_s}, #{@location} )"
	end
end # end MyAdd

class MySubtraction

	attr_reader :left
	attr_reader :right
    attr_reader :location 

	def initialize(left,right,location)
    # Tabs show up as different sizes on different computers.
		@left = left
		@right = right
		@location = location
	end

	def evaluate(environment)
    # All evaluate methods are supposed to return a new model primitive! This
    # makes a new Ruby primitive.
		if @left.class == IntPrimitive || @left.class == FloatPrimitive
			if @left.class == @right.class	
				evalValue = @left.evaluate(environment) - @right.evaluate(environment)
				return @left.class.new(evalValue, @location)
			else
				raise "Syntax error: invalid arguments for MySubtraction at #{@right.location}"
			end
		else
			raise "Syntax error: invalid arguments for MySubtraction at #{@left.location}"
		end
	end
	
	def to_s
		"MySub ( #{@left.to_s} - #{@right.to_s}, #{@location} )"
	end
end # end MySub

class MyMult

    attr_reader :location 
	
	def initialize(left,right,location)
        @left = left
		@right = right
		@location = location
	end

	def evaluate(environment)
		if @left.class == IntPrimitive || @left.class == FloatPrimitive
			if @left.class == @right.class	
				evalValue = @left.evaluate(environment) * @right.evaluate(environment)
				return @left.class.new(evalValue, @location)
			else
				raise "Syntax error: invalid arguments for MyMult at #{@right.location}"
			end
		else
			raise "Syntax error: invalid arguments for MyMult at #{@left.location}"
		end
	end

	def to_s
		"MyMult ( #{@left.to_s} * #{@right.to_s}, #{@location} )"
	end
end # end myMult

class MyDiv

    attr_reader :location 

	def initialize(left,right,location)
        @left = left
		@right = right
		@location = location
	end

	def evaluate(environment)
		if @left.class == IntPrimitive || @left.class == FloatPrimitive
			if @left.class == @right.class	
				evalValue = @left.evaluate(environment) / @right.evaluate(environment)
				return @left.class.new(evalValue, @location)
			else
				raise "Syntax error: invalid arguments for MyDiv at #{@right.location}"
			end
		else
			raise "Syntax error: invalid arguments for MyDiv at #{@left.location}"
		end
	end

	def to_s
		"MyDiv ( #{@left.to_s} / #{@right.to_s}, #{@location} )"
	end
end # end myDiv

class MyModulo
    attr_reader :location 

	def initialize(left,right,location)
        @left = left
		@right = right
		@location = location
	end

	def evaluate(environment)
		if @left.class == IntPrimitive || @left.class == FloatPrimitive
			if @left.class == @right.class	
				evalValue = @left.evaluate(environment) % @right.evaluate(environment)
				return @left.class.new(evalValue, @location)
			else
				raise "Syntax error: invalid arguments for MyModulo at #{@left.location}"
			end
		else
			raise "Syntax error: invalid arguments for MyModulo at #{@left.location}"
		end
	end

	def to_s
		"MyModulo ( #{@left.to_s} % #{@right.to_s}, #{@location} )"
	end
end # end myMod

class MyExponentiation

	attr_reader :value
    attr_reader :location 

	def initialize(left,right,location)
        @left = left
		@right = right
		@location = location
	end

	def evaluate(environment)
		if @left.class == IntPrimitive || @left.class == FloatPrimitive
			if @left.class == @right.class	
				evalValue = @left.evaluate(environment) ** @right.evaluate(environment)
				return @left.class.new(evalValue, @location)
			else
				raise "Syntax error: invalid arguments for MyExponentiation at #{@right.location}"
			end
		else
			raise "Syntax error: invalid arguments for MyExponentiation at #{@left.location}"
		end
	end

	def to_s
		"MyExponentiation ( #{@left.to_s} ** #{@right.to_s}, #{@location} )"
	end

end # end myExp
