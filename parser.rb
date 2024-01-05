class Parser

  attr_reader :tokens

  def initialize(tokens)
    @tokens = tokens
    @current_token = nil
  end

  # parse to parse the complete list of tokens and return an AST\
  def parse
      capture
      expression
  end

  # has to see if the next token has a certain type
  def has(type)
      if @current_token && @current_token.type == type
          capture
        else
          raise "Syntax error: Expected #{type} at position #{@current_token.start_index}"
          return
        end
  end

  # capture to move forward in the tokens list
  def capture()
      @current_token = @tokens.shift
  end

    def atom
      if @current_token.token_type == :INTPRIMITIVE
        value = @current_token.text
        position = [@current_token.start_index, @current_token.end_index]
        capture
        IntPrimitive.new(value, position)
      elsif @current_token.token_type == :FLOATPRIMITIVE
        value = @current_token.text
        position = [@current_token.start_index, @current_token.end_index]
        capture
        FloatPrimitive.new(value, position)
      elsif @current_token.token_type == :BOOLPRIMITIVE
        value = @current_token.text
        position = [@current_token.start_index, @current_token.end_index]
        capture
        BoolPrimitive.new(value, position)
      elsif @current_token.token_type == :STRINGPRIMITIVE
        value = @current_token.text
        position = [@current_token.start_index, @current_token.end_index]
        capture
        StringPrimitive.new(value, position)
      else
        raise "Syntax error: Expected an atom at position #{@current_token.start_index}"
      end
    end

    def expression
      left = atom
      while (@current_token != nil)
        position = [@current_token.start_index, @current_token.end_index]
        if @current_token.token_type == :MYADD
          left = parseMyAdd(left, position)
        elsif @current_token.token_type == :MYSUBTRACTION
          left = parseMySub(left, position)
        elsif @current_token.token_type == :MYMULT
          left = parseMyMult(left, position)
        elsif @current_token.token_type == :MYDIV
          left = parseMyDiv(left, position)
        elsif @current_token.token_type == :MYMODULO
          left = parseMyModulo(left, position)
        elsif @current_token.token_type == :MYEXPONENTIATION
          left = parseMyExp(left, position)
        elsif @current_token.token_type == :MYBITAND
          left = parseMyBitAnd(left, position)
        elsif @current_token.token_type == :MYBITOR
          left = parseMyBitOr(left, position)
        elsif @current_token.token_type == :MYBITXOR
          left = parseMyBitXor(left, position)
        elsif @current_token.token_type == :MYBITNOT
          left = parseMyBitNot(left, position)
        elsif @current_token.token_type == :MYBITLSHIFT
          left = parseMyBitLshift(left, position)
        elsif @current_token.token_type == :MYBITRSHIFT
          left = parseMyBitRshift(left, position)
        elsif @current_token.token_type == :MYFLOATTOINT
          left = parseMyFloatToInt(left, position)
        elsif @current_token.token_type == :MYINTTOFLOAT
          left = parseMyIntToFloat(left, position)
        elsif @current_token.token_type == :MYLVAL
          left = parseMyLVal(left, position)
        elsif @current_token.token_type == :MYRVAL
          left = parseMyRVal(left, position)
        elsif @current_token.token_type == :MYLAND
          left = parseMyLAnd(left, position)
        elsif @current_token.token_type == :MYLOR
          left = parseMyLOr(left, position)
        elsif @current_token.token_type == :MYLNOT
          left = parseMyLNot(left, position)
        elsif @current_token.token_type == :MYEQUALS
          left = parseMyEquals(left, position)
        elsif @current_token.token_type == :MYNOTEQUALS
          left = parseMyNotEquals(left, position)
        elsif @current_token.token_type == :MYLESSTHAN
          left = parseMyLessThan(left, position)
        elsif @current_token.token_type == :MYLESSTHANOREQUAL
          left = parseMyLessThanOrEqual(left, position)
        elsif @current_token.token_type == :MYGREATERTHAN
          left = parseMyGreaterThan(left, position)
        elsif @current_token.token_type == :MYGREATERTHANOREQUAL
          left = parseMyGreaterThanOrEqual(left, position)
        elsif @current_token.token_type == :MYMAX
          left = parseMyMax(left, position)
        elsif @current_token.token_type == :MYMIN
          left = parseMyMin(left, position)
        elsif @current_token.token_type == :MYSUM
          left = parseMySum(left, position)
        elsif @current_token.token_type == :MYMEAN
          left = parseMyMean(left, position)
        else
          # Error for two atoms without an expression
          raise "Syntax error: Expected an expression at position #{@current_token.start_index}"
        end
      end
      left
    end

    def parseMyAdd(left, position)
      capture
      right = atom
      left = MyAdd.new(left, right, position)
      left
    end

    def parseMySub(left, position)
      capture
      right = atom
      left = MySubtraction.new(left, right, position)
      left
    end

    def parseMyMult(left, position)
      capture
      right = atom
      left = MyMult.new(left, right, position)
      left
    end

    def parseMyDiv(left, position)
      capture
      right = atom
      left = MyDiv.new(left, right, position)
      left
    end

    def parseMyModulo(left, position)
      capture
      right = atom
      left = MyModulo.new(left, right, position)
      left
    end

    def parseMyExp(left, position)
      capture
      right = atom
      temp = MyExponentiation.new(left, right, position)
      temp
    end

    def parseMyBitAnd(left, position)
      capture
      right = atom
      left = MyBitAnd.new(left, right, position)
      left
    end

    def parseMyBitOr(left, position)
      capture
      right = atom
      left = MyBitOr.new(left, right, position)
      left
    end

    def parseMyBitXor(left, position)
      capture
      right = atom
      left = MyBitXor.new(left, right, position)
      left
    end

    def parseMyBitNot(left, position)
      capture
      left = MyBitNot.new(left, position)
      left
    end

    def parseMyBitLshift(left, position)
      capture
      right = atom
      left = MyBitLshift.new(left, right, position)
      left
    end

    def parseMyBitRshift(left, position)
      capture
      right = atom
      left = MyBitRshift.new(left, right, position)
      left
    end

    def parseMyFloatToInt(left, position)
      capture
      # right = atom
      left = MyFloatToInt.new(left, position)
      left
    end

    def parseMyIntToFloat(left, position)
      capture
      # right = atom
      left = MyIntToFloat.new(left, position)
      left
    end

    def parseMyLVal(left, position)
      capture
      right = atom
      left = MyLVal.new(left, right, position)
      left
    end

    def parseMyRVal(left, position)
      capture
      right = atom
      left = MyRVal.new(left, right, position)
      left
    end

    def parseMyLAnd(left, position)
      capture
      right = atom
      left = MyLAnd.new(left, right, position)
      left
    end

    def parseMyLOr(left, position)
      capture
      right = atom
      left = MyLOr.new(left, right, position)
      left
    end

    def parseMyLNot(left, position)
      capture
      # right = atom
      left = MyLNot.new(left, position)
      left
    end

    def parseMyEquals(left, position)
      capture
      right = atom
      left = MyEquals.new(left, right, position)
      left
    end

    def parseMyNotEquals(left, position)
      capture
      right = atom
      left = MyNotEquals.new(left, right, position)
      left
    end

    def parseMyLessThan(left, position)
      capture
      right = atom
      left = MyLessThan.new(left, right, position)
      left
    end

    def parseMyLessThanOrEqual(left, position)
      capture
      right = atom
      left = MyLessThanOrEqual.new(left, right, position)
      left
    end

    def parseMyGreaterThan(left, position)
      capture
      right = atom
      left = MyGreaterThan.new(left, right, position)
      left
    end

    def parseMyGreaterThanOrEqual(left, position)
      capture
      right = atom
      left = MyGreaterThanOrEqual.new(left, right, position)
      left
    end

    def parseMyMax(left, position)
      capture
      right = atom
      left = MyMax.new(left, right, position)
      left
    end

    def parseMyMin(left, position)
      capture
      right = atom
      left = MyMin.new(left, right, position)
      left
    end

    def parseMySum(left, position)
      capture
      right = atom
      left = MySum.new(left, right, position)
      left
    end

    def parseMyMean(left, position)
      capture
      right = atom
      temp = MyMean.new(left, right, position)
      temp
    end
end

# --------------- Start Main ---------------

require_relative 'token'
require_relative 'primitive'
require_relative 'arithmetic'
require_relative 'bitwise'
require_relative 'stats'
require_relative 'relational'
require_relative 'logicOps'
require_relative 'cellVals'
require_relative 'casting'
require_relative 'grid'
require_relative 'environment'

# --------------- normal output ---------------

# create grid and environment then set values for grid for later evaluate calls
grid = Grid.new(3,3)
environment = Environment.new(grid)
add1 = MyAdd.new(IntPrimitive.new(3,0), IntPrimitive.new(2,0), 0)
sub1 = MySubtraction.new(IntPrimitive.new(9,1), IntPrimitive.new(5,2), 1)
lval1 = MyLVal.new(0,0,0)
lval2 = MyLVal.new(0,1,0)
lval3 = MyLVal.new(1,0,0)

sum1 = MySum.new(lval1, lval2, 0)

grid.setCell(lval1, add1)
grid.setCell(lval2, sub1)
grid.setCell(lval3, sum1)


# ------------ End Initializing Variables ------------


# input_text = "10 >= 0"
# tokenized = Token.lexer(input_text)
# parser = Parser.new(tokenized)
# ast = parser.parse
# puts 'Abstract Syntax Trees:'
# if (ast.evaluate(environment) != nil)
#   puts ast.to_s
# end

# input_text = "true && false"
# tokenized = Token.lexer(input_text)
# parser = Parser.new(tokenized)
# ast = parser.parse
# if (ast.evaluate(environment) != nil)
#   puts ast.to_s
# end

# input_text = "21.1 fti"
# tokenized = Token.lexer(input_text)
# parser = Parser.new(tokenized)
# ast = parser.parse
# if (ast.evaluate(environment) != nil)
#   puts ast.to_s
# end

# input_text = "2 << 10"
# tokenized = Token.lexer(input_text)
# parser = Parser.new(tokenized)
# ast = parser.parse
# if (ast.evaluate(environment) != nil)
#   puts ast.to_s
# end

# input_text = "Hello == Hello"
# tokenized = Token.lexer(input_text)
# parser = Parser.new(tokenized)
# ast = parser.parse
# if (ast.evaluate(environment) != nil)
#   puts ast.to_s
# end

# input_text = "0 (L) 0"
# tokenized = Token.lexer(input_text)
# parser = Parser.new(tokenized)
# ast = parser.parse
# if (ast.evaluate(environment) != nil)
#   puts ast.to_s
# end

# input_text = "0 (L) 1"
# tokenized = Token.lexer(input_text)
# parser = Parser.new(tokenized)
# ast = parser.parse
# if (ast.evaluate(environment) != nil)
#   puts ast.to_s
# end

# input_text = "1 (L) 0"
# tokenized = Token.lexer(input_text)
# parser = Parser.new(tokenized)
# ast = parser.parse
# if (ast.evaluate(environment) != nil)
#   puts ast.to_s
# end

# ------------ End Basic Tests ------------
# ------------ Begin Error Tests ------------


# input_text = "WHATTHE / 1"
# tokenized = Token.lexer(input_text)
# parser = Parser.new(tokenized)
# ast = parser.parse
# puts ' --------------- Incorrect type AST   --------------- '
# if (ast.evaluate(environment) != nil)
#   puts ast.to_s
# end

# input_text = "IDK == true"
# tokenized = Token.lexer(input_text)
# parser = Parser.new(tokenized)
# ast = parser.parse
# if (ast.evaluate(environment) != nil)
#   puts ast.to_s
# end



# --------------- atom error ---------------
# input_text = "3 + -"
# tokenized = Token.lexer(input_text)

# parser = Parser.new(tokenized)
# ast = parser.parse

# puts 'Abstract Syntax Tree with no atoms:'
# puts ast.to_s

# --------------- expression error ---------------
# input_text = "9 10 /"
# tokenized = Token.lexer(input_text)

# parser = Parser.new(tokenized)
# ast = parser.parse

# puts 'Abstract Syntax Tree with no expressions:'
# puts ast.to_s
