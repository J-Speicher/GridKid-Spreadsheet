# assert int operands
class MyBitAnd
	attr_reader :location

    def initialize(left,right,location)
        @left = left
		@right = right
		@location = location
	end

	def evaluate(environment)
		if @left.class == IntPrimitive
			if @left.class == @right.class
				evalValue = @left.evaluate(environment) & @right.evaluate(environment)
				return @left.class.new(evalValue, @location)
			else
				"Syntax error: invalid arguments for MyBitAnd at #{@right.location}"
			end
		else
			"Syntax error: invalid arguments for MyBitAnd at #{@left.location}"
		end
	end

	def to_s
		"MyBitAnd ( #{@left.to_s} & #{@right.to_s}, #{@location} )"
	end
end

class MyBitOr
	attr_reader :location

    def initialize(left,right,location)
        @left = left
		@right = right
		@location = location
	end

	def evaluate(environment)
		if @left.class == IntPrimitive
			if @left.class == @right.class
				evalValue = @left.evaluate(environment) | @right.evaluate(environment)
				return @left.class.new(evalValue, @location)
			else
				"Syntax error: invalid arguments for MyBitOr at #{@right.location}"
			end
		else
			"Syntax error: invalid arguments for MyBitOr at #{@left.location}"
		end
	end

	def to_s
		"MyBitOr ( #{@left.to_s} | #{@right.to_s}, #{@location} )"
	end
end

class MyBitXor
	attr_reader :location

    def initialize(left,right,location)
        @left = left
		@right = right
		@location = location
	end

	def evaluate(environment)
		if @left.class == IntPrimitive
			if @left.class == @right.class
				evalValue = @left.evaluate(environment) ^ @right.evaluate(environment)
				return @left.class.new(evalValue, @location)
			else
				"Syntax error: invalid arguments for MyBitXor at #{@right.location}"
			end
		else
			"Syntax error: invalid arguments for MyBitXor at #{@left.location}"
		end
	end

	def to_s
		"MyBitXor ( #{@left.to_s} ^ #{@right.to_s}, #{@location} )"
	end
end

class MyBitNot
	attr_reader :location

    def initialize(value, location)
        @value = value
		@location = location
	end

	def evaluate(environment)
		if @value.class == IntPrimitive
			evalValue = ~(@value.evaluate(environment))
			return @value.class.new(evalValue, @location)
		else
			"Syntax error: invalid arguments for MyBitNot at #{@value.location}"
		end
	end

	def to_s
		"MyBitNot ( ~#{@value.to_s}, #{@location} )"
	end
end

class MyBitLshift
	attr_reader :location

    def initialize(left,right,location)
        @left = left
		@right = right
		@location = location
	end

	def evaluate(environment)
		if @left.class == IntPrimitive
			if @left.class == @right.class
				evalValue = (@left.evaluate(environment) << @right.evaluate(environment)) / 2
				return @left.class.new(evalValue, @location)
			else
				"Syntax error: invalid arguments for MyBitLshift at #{@right.location}"
			end
		else
			"Syntax error: invalid arguments for MyBitLshift at #{@left.location}"
		end
	end

	def to_s
		"MyBitLshift ( #{@left.to_s} << #{@right.to_s}, #{@location} )"
	end
end

class MyBitRshift
	attr_reader :location

    def initialize(left,right,location)
        @left = left
		@right = right
		@location = location
	end

	def evaluate(environment)
		if @left.class == IntPrimitive
			if @left.class == @right.class
				evalValue = @left.evaluate(environment) >> @right.evaluate(environment)
				return @left.class.new(evalValue, @location)
			else
				"Syntax error: invalid arguments for MyBitRshift at #{@right.location}"
			end
		else
			"Syntax error: invalid arguments for MyBitRshift at #{@left.location}"
		end
	end

	def to_s
		"MyBitRshift ( #{@left.to_s} >> #{@right.to_s}, #{@location} )"
	end
end
